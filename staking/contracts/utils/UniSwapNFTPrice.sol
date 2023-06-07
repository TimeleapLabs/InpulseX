// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "https://github.com/Uniswap/v3-periphery/blob/0.8/contracts/interfaces/INonfungiblePositionManager.sol";

import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/IUniswapV3Pool.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/IUniswapV3Factory.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/libraries/TickMath.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/libraries/FullMath.sol";

import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/pool/IUniswapV3PoolImmutables.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/pool/IUniswapV3PoolState.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/pool/IUniswapV3PoolDerivedState.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/pool/IUniswapV3PoolActions.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/pool/IUniswapV3PoolOwnerActions.sol";
import "https://github.com/Uniswap/v3-core/blob/0.8/contracts/interfaces/pool/IUniswapV3PoolEvents.sol";

import "./LiquidityAmounts.sol";

/**
 * @title Extended ERC20 interface
 * @notice Interface for ERC20, with decimals() method included
 */
interface IERC20Extented is IERC20 {
    function decimals() external view returns (uint8);
}

/**
 * @title Uniswap NFT Price
 * @notice This contract is used for calculating the price of a Uniswap NFT
 */
contract UniSwapNFTPrice {
    /**
     * @notice Nonfungible position manager of Uniswap
     */
    INonfungiblePositionManager public positionManager;

    /**
     * @notice Uniswap pool
     */
    IUniswapV3Pool public pool;

    /**
     * @notice Pair pool for Uniswap
     */
    IUniswapV3Pool public pairPool;

    /**
     * @notice The token of interest
     */
    address private token;

    /**
     * @param _positionManager The address of Uniswap position manager
     * @param _pool The address of Uniswap pool
     * @param _token The address of the token of interest
     */
    constructor(address _positionManager, address _pool, address _token) {
        positionManager = INonfungiblePositionManager(_positionManager);
        pool = IUniswapV3Pool(_pool);
        token = _token;
    }

    /**
     * @notice Calculate price from liquidity
     * @dev This method calculates the price using liquidity data from the pool
     * @return Returns the calculated price
     */
    function calculatePriceFromLiquidity() public view returns (uint256) {
        (uint160 sqrtPriceX96, , , , , , ) = pool.slot0();
        uint256 decimals = IERC20Extented(pool.token0()).decimals();
        uint256 numerator1 = uint256(sqrtPriceX96) * uint256(sqrtPriceX96);
        uint256 numerator2 = 10 ** decimals;
        return FullMath.mulDiv(numerator1, numerator2, 1 << 192);
    }

    /**
     * @notice Get price of token
     * @param tokenId The ID of the token
     * @return The price of the token
     */
    function getPrice(uint tokenId) public view returns (uint) {
        (
            ,
            ,
            address token0,
            address token1,
            ,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            ,
            ,
            ,

        ) = positionManager.positions(tokenId);

        (, int24 tick, , , , , ) = pool.slot0();

        (uint256 amount0, uint256 amount1) = LiquidityAmounts
            .getAmountsForLiquidity(
                TickMath.getSqrtRatioAtTick(tick),
                TickMath.getSqrtRatioAtTick(tickLower),
                TickMath.getSqrtRatioAtTick(tickUpper),
                liquidity
            );

        uint256 decimalsToken1 = IERC20Extented(pool.token1()).decimals();
        uint256 price = calculatePriceFromLiquidity();

        // If our token is token1, then amount0 is the amount of eth
        // and vice-versa
        if (token == token1) {
            return (amount0 +
                FullMath.mulDiv(amount1, 10 ** decimalsToken1, price));
        } else {
            return (amount1 +
                FullMath.mulDiv(amount1, price, 10 ** decimalsToken1));
        }
    }
}
