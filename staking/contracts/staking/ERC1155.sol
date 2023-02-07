// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";
import "../interfaces/IERC1155.sol";
import "../interfaces/IERC1155Receiver.sol";
import "../rewards/ERC20.sol";
import "../rewards/ERC1155.sol";

abstract contract ERC1155Staking is BaseStaking, IERC1155Receiver {
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
        if (block.timestamp < _unlockTime) {
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
            sendRewards(user, reward);
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

contract ERC1155StakerERC20Rewarder is ERC1155Staking, ERC20Rewards {}

contract ERC1155StakerERC1155Rewarder is ERC1155Staking, ERC1155Rewards {}
