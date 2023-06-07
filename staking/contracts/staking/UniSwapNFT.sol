// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "../Base.sol";
import "../rewards/ERC20.sol";
import "../rewards/ERC1155.sol";
import "../utils/UniSwapNFTPrice.sol";

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC721Receiver.sol";

abstract contract UniSwapStaking is BaseStaking, IERC165, IERC721Receiver {
    IERC721 private _stakeToken;
    UniSwapNFTPrice private _uniSwapNftPrice;

    event LPStakingTokenChanged(address token);

    /**
     * @param positionManager The address of Uniswap position manager
     * @param pool The address of Uniswap pool
     * @param token The address of the staking token
     */
    constructor(address positionManager, address pool, address token) {
        require(token != address(0), "Can't set token to address(0)");
        require(pool != address(0), "Can't set pool to address(0)");
        require(
            positionManager != address(0),
            "Can't set position manager to address(0)"
        );
        _uniSwapNftPrice = new UniSwapNFTPrice(positionManager, pool, token);
        _stakeToken = IERC721(positionManager);
        emit StakingTokenChanged(positionManager);
        emit LPStakingTokenChanged(token);
    }

    mapping(address => uint256[]) _stakeIds;

    /**
     * @dev Get the address of the token used for staking
     * @return address Address of the token contract
     */
    function getStakingToken() external view returns (address) {
        return address(_stakeToken);
    }

    event StakedLP(uint256 eth);

    /**
     * @dev Transfers NFT with `id` from the user to this contract
     * @param id ID of the NFT to stake
     *
     * Reverts if staking window is smaller than the block timestamp
     */
    function stake(uint256 id) public {
        require(_unlockTime > 0, "Cannot stake yet");
        require(block.timestamp <= _unlockTime, "Cannot stake anymore");

        address user = _msgSender();
        uint256 eth = _uniSwapNftPrice.getPrice(id);

        recordStakeWeight(user, eth);
        _stakeIds[user].push(id);

        emit Staked(user, 1);
        emit StakedLP(eth);

        _stakeToken.safeTransferFrom(user, address(this), id, "");
    }

    /**
     * @dev Transfers NFT with `id` from the user to this contract
     * @param ids IDs of the NFTs to stake
     * @param length Number of NFTs to stake
     *
     * Reverts if staking window is smaller than the block timestamp
     */
    function stakeMany(uint256[] calldata ids, uint256 length) external {
        for (uint256 index = 0; index < length; index++) {
            stake(ids[index]);
        }
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
        uint256 amount = _stakeIds[user].length;

        require(amount > 0, "Cannot unstake 0 tokens");
        require(canUnstake(user), "Cannot unstake yet");

        uint256[] memory nftIds = _stakeIds[user];

        delete _stakeIds[user];
        emit UnStaked(user, amount);

        if (_exceptions[user]) {
            /**
             * No reward distributed, decrease the stake pool size
             */
            _stakePoolWeight -= _stakeWeight[user];
            _stakeWeight[user] = 0;
        } else {
            uint256 reward = getRewardSize(user);
            _stakeWeight[user] = 0;
            sendRewards(user, reward);
        }

        for (uint256 index = 0; index < amount; index++) {
            _stakeToken.safeTransferFrom(
                address(this),
                user,
                nftIds[index],
                ""
            );
        }
    }

    /**
     * @dev Returns the NFT IDs currently staked by the user
     * @param user Address of the user staking tokens
     * @return uint256[] NFT IDs staked by the `user`
     */
    function getStakeIds(
        address user
    ) external view returns (uint256[] memory) {
        return _stakeIds[user];
    }

    /* ERC721 methods */

    /**
     * @dev See {IERC721-onERC721Received}.
     */
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
    function supportsInterface(
        bytes4 interfaceId
    ) public pure virtual override(IERC165) returns (bool) {
        return interfaceId == type(IERC721Receiver).interfaceId;
    }
}

contract UniSwapStakerERC20Rewarder is UniSwapStaking, ERC20Rewards {
    constructor(
        address positionManager,
        address pool,
        address token
    ) UniSwapStaking(positionManager, pool, token) {}
}

contract UniSwapStakerERC1155Rewarder is UniSwapStaking, ERC1155Rewards {
    constructor(
        address positionManager,
        address pool,
        address token
    ) UniSwapStaking(positionManager, pool, token) {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public pure override(UniSwapStaking, ERC1155Rewards) returns (bool) {
        return
            UniSwapStaking.supportsInterface(interfaceId) ||
            ERC1155Rewards.supportsInterface(interfaceId);
    }
}
