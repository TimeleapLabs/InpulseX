// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../Base.sol";
import "../interfaces/IERC20.sol";
import "../interfaces/IERC721.sol";
import "../interfaces/IERC721Receiver.sol";
import "../rewards/ERC20.sol";
import "../rewards/ERC1155.sol";

abstract contract ERC721Staking is BaseStaking, IERC721Receiver {
    IERC721 private _stakeToken;

    mapping(address => uint256[]) _stakeIds;

    function setStakingToken(address token) external onlyOwner {
        require(token != address(0), "Can't set token to address(0)");
        _stakeToken = IERC721(token);
    }

    function getStakingToken() external view returns (address) {
        return address(_stakeToken);
    }

    function stake(uint256 id) external {
        address user = _msgSender();

        _stakePoolSize += 1;
        _stakeIds[user].push(id);

        _stakeToken.safeTransferFrom(user, address(this), id, "");

        emit Staked(user, 1);
    }

    function unstake() external {
        address user = _msgSender();
        uint256 amount = _stakeIds[user].length;

        require(amount > 0, "Cannot unstake 0 tokens");
        require(
            block.timestamp >= _unlockTime || _exceptions[user],
            "Cannot unstake yet"
        );

        for (uint256 index = 0; index < amount; index++) {
            _stakeToken.safeTransferFrom(
                address(this),
                user,
                _stakeIds[user][index],
                ""
            );
        }

        emit UnStaked(user, amount);
        delete _stakeIds[user];

        if (_exceptions[user]) {
            /**
             * No reward distributed, decrease the stake pool size
             */
            _stakePoolSize -= amount;
        } else {
            uint256 reward = (((amount * 100) / _stakePoolSize) *
                _rewardPoolSize) / 100;
            sendRewards(user, reward);
        }
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external view returns (bytes4) {
        return IERC721Receiver(this).onERC721Received.selector;
    }

    /* ERC165 methods */

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
        return interfaceId == type(IERC721Receiver).interfaceId;
    }
}

contract ERC721StakerERC20Rewarder is ERC721Staking, ERC20Rewards {}

contract ERC721StakerERC1155Rewarder is ERC721Staking, ERC1155Rewards {}
