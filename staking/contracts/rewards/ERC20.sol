// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";

abstract contract ERC20Rewards is BaseStaking {
    IERC20 internal _rewardToken;

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
        require(
            _rewardToken.transferFrom(_msgSender(), address(this), amount),
            "Transfer failed!"
        );
    }

    function recoverRewards(uint256 amount) external onlyOwner {
        require(amount > 0, "Cannot remove 0 tokens");
        _rewardPoolSize -= amount;
        require(
            _rewardToken.transfer(_msgSender(), amount),
            "Transfer failed!"
        );
    }

    function sendRewards(address user, uint256 amount)
        internal
        override(BaseStaking)
    {
        require(_rewardToken.transfer(user, amount), "Transfer failed!");
    }
}
