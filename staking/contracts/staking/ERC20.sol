// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";
import "../rewards/ERC20.sol";
import "../rewards/ERC1155.sol";

abstract contract ERC20Staking is BaseStaking {
    IERC20 private _stakeToken;

    /**
     * @dev Set the token used for staking
     * @param token Address of the token contract
     *
     * Reverts if the token is set to address(0)
     */
    function setStakingToken(address token) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC20(token);
    }

    /**
     * @dev Get the address of the token used for staking
     * @return address Address of the token contract
     */
    function getStakingToken() external view returns (address) {
        return address(_stakeToken);
    }

    /**
     * @dev Transfers `amount` tokens from the user to this contract
     * @param amount Amount of tokens being staked
     *
     * Reverts if `amount` is not greater than 0
     * Reverts if staking window is smaller than the block timestamp
     */
    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");
        require(block.timestamp <= _stakingWindow, "Cannot stake anymore");
        address user = _msgSender();
        _stake[user] += amount;
        _stakePoolSize += amount;
        emit Staked(user, amount);
        require(
            _stakeToken.transferFrom(user, address(this), amount),
            "Transfer failed!"
        );
    }

    /**
     * @dev Unstake tokens
     *
     * Reverts if user stake amount is not greater than 0
     * Reverts if block timestamp is not bigger than the unlock time
     * or the user is not allowed to unstake early
     *
     * A penalty may be applied if the user removes their stake early
     */
    function unstake() external {
        address user = _msgSender();
        require(_stake[user] > 0, "Cannot unstake 0 tokens");
        require(canUnstake(user), "Cannot unstake yet");

        uint256 amount = _stake[user];
        _stake[user] = 0;

        if (block.timestamp < _unlockTime) {
            uint256 penalty = (amount * _penalties[user]) / 100;
            emit UnStaked(user, amount - penalty);

            /**
             * No reward distributed, decrease the stake pool size
             */
            _stakePoolSize -= amount;

            if (penalty > 0) {
                require(
                    _stakeToken.transfer(_penaltyAddress, penalty),
                    "Transfer failed!"
                );
            }

            require(
                _stakeToken.transfer(user, amount - penalty),
                "Transfer failed!"
            );
        } else {
            emit UnStaked(user, amount);
            uint256 reward = (amount * _rewardPoolSize) / _stakePoolSize;
            require(_stakeToken.transfer(user, amount), "Transfer failed!");
            sendRewards(user, reward);
        }
    }

    /**
     * @dev Get the current reward size for `user`
     * @param user Address of the user
     */
    function getRewardSize(address user) external view returns (uint256) {
        uint256 amount = _stake[user];
        return (amount * _rewardPoolSize) / _stakePoolSize;
    }
}

contract ERC20StakerERC20Rewarder is ERC20Staking, ERC20Rewards {}

contract ERC20StakerERC1155Rewarder is ERC20Staking, ERC1155Rewards {}
