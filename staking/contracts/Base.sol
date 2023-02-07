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

    function setUnlockTime(uint256 timestamp) external onlyOwner {
        _unlockTime = timestamp;
    }

    function reduceUnlockTime(uint256 timestamp) external onlyOwner {
        require(
            timestamp < _unlockTime,
            "Unlock time bigger than the current one"
        );
        _unlockTime = timestamp;
    }

    function getUnlockTime() external view returns (uint256) {
        return _unlockTime;
    }

    function setPenaltyAddress(address penalty) external onlyOwner {
        require(
            penalty != address(0),
            "Cannot set penalty collection address to 0x0"
        );
        _penaltyAddress = penalty;
    }

    function setStakingWindow(uint256 timestamp) external onlyOwner {
        _stakingWindow = timestamp;
    }

    function getStakingWindow() external view returns (uint256) {
        return _stakingWindow;
    }

    function allowUnstakeWithPenalty(address user, uint256 penalty)
        external
        onlyOwner
    {
        _exceptions[user] = true;
        _penalties[user] = penalty;
    }

    function disallowUnstakeWithPenalty(address user) external onlyOwner {
        _exceptions[user] = false;
        _penalties[user] = 0;
    }

    function getStake(address user) external view returns (uint256) {
        return _stake[user];
    }

    function sendRewards(address user, uint256 amount) internal virtual;
}
