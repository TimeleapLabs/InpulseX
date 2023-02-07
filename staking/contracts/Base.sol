// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./libraries/Context.sol";
import "./libraries/Ownable.sol";

abstract contract BaseStaking is Context, Ownable {
    uint256 internal _stakePoolSize;
    uint256 internal _rewardPoolSize;
    uint256 internal _unlockTime;
    uint256 internal _stakingWindow;
    address internal _penaltyAddress;

    mapping(address => bool) internal _exceptions;
    mapping(address => uint256) internal _penalties;
    mapping(address => uint256) internal _stake;

    event Staked(address user, uint256 amount);
    event UnStaked(address user, uint256 amount);

    constructor() {
        _stake[msg.sender] = 0;
    }

    /**
     * @dev Sets the unlock time of this staking contract
     * @param timestamp The unlock time of the contract
     */
    function setUnlockTime(uint256 timestamp) external onlyOwner {
        _unlockTime = timestamp;
    }

    /**
     * @dev Allows reducing the unlock time of the contract
     * @param timestamp The new unlock time for the contract
     */
    function reduceUnlockTime(uint256 timestamp) external onlyOwner {
        require(
            timestamp < _unlockTime,
            "Unlock time bigger than the current one"
        );
        _unlockTime = timestamp;
    }

    /**
     * @dev Allows reading the current unlock time of the contract
     * @return uint256 The current unlock "timestamp"
     */
    function getUnlockTime() external view returns (uint256) {
        return _unlockTime;
    }

    /**
     * @dev Sets the penalty collection address for early unstakings
     * @param penalty The address that collects the penalties
     */
    function setPenaltyAddress(address penalty) external onlyOwner {
        require(
            penalty != address(0),
            "Cannot set penalty collection address to 0x0"
        );
        _penaltyAddress = penalty;
    }

    /**
     * @dev Sets the staking window; users won't be able to stake after
     * this timestamp
     * @param timestamp Set the staking window to this timestamp
     */
    function setStakingWindow(uint256 timestamp) external onlyOwner {
        _stakingWindow = timestamp;
    }

    /**
     * @dev Returns the current staking window timestamp
     * @return uint256 The current staking window
     */
    function getStakingWindow() external view returns (uint256) {
        return _stakingWindow;
    }

    /**
     * @dev Allow `user` to unstake early with an optional penalty
     * @param user Address of the user to add to exceptions
     * @param penalty The penalty percentage (e.g. 5 means 5% penalty)
     */
    function allowUnstakeWithPenalty(address user, uint256 penalty)
        external
        onlyOwner
    {
        _exceptions[user] = true;
        _penalties[user] = penalty;
    }

    /**
     * @dev Disallows user from unstaking early (default behavior)
     * @param user Address of the user to remove from exceptions
     */
    function disallowUnstakeWithPenalty(address user) external onlyOwner {
        _exceptions[user] = false;
        _penalties[user] = 0;
    }

    /**
     * @dev Returns the amount of tokens currently staked by the user
     * @param user Address of the user staking tokens
     * @return uint256 Amount of tokens staked by the `user`
     */
    function getStake(address user) external view returns (uint256) {
        return _stake[user];
    }

    /**
     * @dev Sends staking rewards to a user
     * @param user Address of the user to send the rewards to
     * @param amount Amount of tokens to transfer to the user
     */
    function sendRewards(address user, uint256 amount) internal virtual;
}
