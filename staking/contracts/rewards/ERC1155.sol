// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC1155.sol";

abstract contract ERC1155Rewards is BaseStaking {
    IERC1155 internal _rewardToken;
    uint256 internal _rewardNftId;

    function setRewardToken(address token, uint256 id) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _rewardToken = IERC1155(token);
        _rewardNftId = id;
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

    function sendRewards(address user, uint256 amount)
        internal
        override(BaseStaking)
    {
        _rewardToken.safeTransferFrom(
            address(this),
            user,
            _rewardNftId,
            amount,
            ""
        );
    }
}
