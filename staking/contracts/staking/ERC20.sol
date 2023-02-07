// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";
import "../rewards/ERC20.sol";
import "../rewards/ERC1155.sol";

abstract contract ERC20Staking is BaseStaking {
    IERC20 private _stakeToken;

    function setStakingToken(address token) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC20(token);
    }

    function getStakingToken() external view returns (address) {
        return address(_stakeToken);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");
        address user = _msgSender();
        _stake[user] += amount;
        _stakePoolSize += amount;
        require(
            _stakeToken.transferFrom(user, address(this), amount),
            "Transfer failed!"
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
            require(
                _stakeToken.transfer(_penaltyAddress, penalty),
                "Transfer failed!"
            );
            require(
                _stakeToken.transfer(user, amount - penalty),
                "Transfer failed!"
            );
            emit UnStaked(user, amount - penalty);
            /**
             * No reward distributed, decrease the stake pool size
             */
            _stakePoolSize -= amount;
        } else {
            uint256 reward = (((amount * 100) / _stakePoolSize) *
                _rewardPoolSize) / 100;
            require(_stakeToken.transfer(user, amount), "Transfer failed!");
            sendRewards(user, reward);
            emit UnStaked(user, amount);
        }
    }
}

contract ERC20StakerERC20Rewarder is ERC20Staking, ERC20Rewards {}

contract ERC20StakerERC1155Rewarder is ERC20Staking, ERC1155Rewards {}
