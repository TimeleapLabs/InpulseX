// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC1155.sol";
import "../interfaces/IERC1155Receiver.sol";

contract ERC1155Staking is BaseStaking, IERC1155Receiver {
    IERC1155 private _stakeToken;
    IERC1155 private _rewardToken;
    uint256 private _stakeNftId;
    uint256 private _rewardNftId;

    function setStakingToken(address token, uint256 nftId) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC1155(token);
        _stakeNftId = nftId;
    }

    function getStakingToken() external view returns (address, uint256) {
        return (address(_stakeToken), _stakeNftId);
    }

    function setRewardToken(address token, uint256 nftId) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC1155(token);
        _rewardNftId = nftId;
    }

    function getRewardToken() external view returns (address, uint256) {
        return (address(_rewardToken), _rewardNftId);
    }

    function addReward(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");
        _rewardPoolSize += amount;
        _rewardToken.safeTransferFrom(
            _msgSender(),
            address(this),
            _rewardNftId,
            amount,
            ""
        );
    }

    function recoverRewards(uint256 amount) external onlyOwner {
        require(amount > 0, "Cannot remove 0 tokens");
        _rewardPoolSize -= amount;
        _rewardToken.safeTransferFrom(
            address(this),
            _msgSender(),
            _rewardNftId,
            amount,
            ""
        );
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
        if (_penalties[user] > 0) {
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
            uint256 reward = (((amount * 100) / _stakePoolSize) *
                _rewardPoolSize) / 100;
            _stakeToken.safeTransferFrom(
                address(this),
                user,
                _stakeNftId,
                amount,
                ""
            );
            _rewardToken.safeTransferFrom(
                address(this),
                user,
                _rewardNftId,
                amount,
                ""
            );
            emit UnStaked(user, amount);
        }
    }

    function onERC1155Received(
        address,
        address user,
        uint256 id,
        uint256 amount,
        bytes calldata
    ) external returns (bytes4) {
        require(
            _msgSender() == address(_stakeToken),
            "Message sender is not the stake token"
        );
        require(id == _stakeNftId, "Unexpected NFT ID");
        require(amount > 0, "Cannot stake 0 tokens");

        _stake[user] += amount;
        _stakePoolSize += amount;

        emit Staked(user, amount);
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
