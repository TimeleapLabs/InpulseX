// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./libraries/Context.sol";
import "./libraries/Ownable.sol";

contract BaseStaking is Context, Ownable {
    uint256 private _unlockTime;
    uint256 private _stakingWindow;

    constructor() {}

    function setUnlockTime(uint256 timestamp) external onlyOwner {
        _unlockTime = timestamp;
    }

    function getUnlockTime() external view returns (uint256) {
        return _unlockTime;
    }

    function setStakingWindow(uint256 timestamp) external onlyOwner {
        _stakingWindow = timestamp;
    }

    function getStakingWindow() external view returns (uint256) {
        return _stakingWindow;
    }
}
