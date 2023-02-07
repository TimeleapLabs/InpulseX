// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";
import "../interfaces/IERC1363.sol";
import "../interfaces/IERC1363Receiver.sol";
import "../rewards/ERC20.sol";
import "../rewards/ERC1155.sol";

abstract contract ERC1363Staking is BaseStaking, IERC1363Receiver {
    IERC1363 private _stakeToken;

    function setStakingToken(address token) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC1363(token);
    }

    function getStakingToken() external view returns (address) {
        return address(_stakeToken);
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

    function onTransferReceived(
        address,
        address user,
        uint256 amount,
        bytes memory
    ) external returns (bytes4) {
        require(
            _msgSender() == address(_stakeToken),
            "Message sender is not the stake token"
        );

        require(amount > 0, "Cannot stake 0 tokens");
        _stake[user] += amount;
        _stakePoolSize += amount;

        emit Staked(user, amount);

        return IERC1363Receiver(this).onTransferReceived.selector;
    }

    /* ERC165 methods */

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
        return interfaceId == type(IERC1363Receiver).interfaceId;
    }
}

contract ERC1363StakerERC20Rewarder is ERC1363Staking, ERC20Rewards {}

contract ERC1363StakerERC1155Rewarder is ERC1363Staking, ERC1155Rewards {}
