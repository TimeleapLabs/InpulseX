// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";
import "../interfaces/IERC1155.sol";
import "../interfaces/IERC1155Receiver.sol";

contract ERC1155Staking is BaseStaking, IERC1155Receiver {
    IERC20 private _rewardToken;
    IERC1155 private _stakeToken;
    uint256 private _stakeNftId;

    function setStakingToken(address token, uint256 nftId) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC1155(token);
        _stakeNftId = nftId;
    }

    function getStakingToken() external view returns (address, uint256) {
        return (address(_stakeToken), _stakeNftId);
    }

    function setRewardToken(address token) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _rewardToken = IERC20(token);
    }

    function getRewardToken() external view returns (address) {
        return address(_rewardToken);
    }

    function addReward(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");
        _rewardPoolSize += amount;
        _rewardToken.transferFrom(_msgSender(), address(this), amount);
    }

    function recoverRewards(uint256 amount) external onlyOwner {
        require(amount > 0, "Cannot remove 0 tokens");
        _rewardPoolSize -= amount;
        _rewardToken.transferFrom(address(this), _msgSender(), amount);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");

        address user = _msgSender();

        _stake[user] += amount;
        _stakePoolSize += amount;

        _stakeToken.safeTransferFrom(
            user,
            address(this),
            _stakeNftId,
            amount,
            ""
        );

        emit Staked(user, amount);
    }

    function unstake() external {
        address user = _msgSender();
        require(_stake[user] > 0, "Cannot unstake 0 tokens");
        require(
            block.timestamp >= _unlockTime || _exceptions[user],
            "Cannot unstake yet"
        );
        uint256 amount = _stake[user];
        _stake[user] = 0;
        if (_exceptions[user] && block.timestamp < _unlockTime) {
            uint256 penalty = (amount * _penalties[user]) / 100;
            _stakeToken.safeTransferFrom(
                address(this),
                _penaltyAddress,
                _stakeNftId,
                penalty,
                ""
            );
            _stakeToken.safeTransferFrom(
                address(this),
                user,
                _stakeNftId,
                amount - penalty,
                ""
            );
            emit UnStaked(user, amount - penalty);
            /**
             * No reward distributed, decrease the stake pool size
             */
            _stakePoolSize -= amount;
        } else {
            _stakeToken.safeTransferFrom(
                address(this),
                user,
                _stakeNftId,
                amount,
                ""
            );
            uint256 reward = (((amount * 100) / _stakePoolSize) *
                _rewardPoolSize) / 100;
            _rewardToken.transferFrom(address(this), user, reward);
            emit UnStaked(user, amount);
        }
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external view returns (bytes4) {
        return IERC1155Receiver(this).onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure returns (bytes4) {
        return 0x00000000;
    }

    /* ERC165 methods */

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
        return interfaceId == type(IERC1155Receiver).interfaceId;
    }
}
