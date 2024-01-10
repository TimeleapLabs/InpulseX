import { ethers } from 'ethers';
import { publicRpcs } from './onboard';

const provider = new ethers.providers.JsonRpcProvider(publicRpcs.ethereum);

const poolABI = [
	`function slot0()
    external
    view
    returns (
      uint160 sqrtPriceX96,
      int24 tick,
      uint16 observationIndex,
      uint16 observationCardinality,
      uint16 observationCardinalityNext,
      uint8 feeProtocol,
      bool unlocked
    )`
];

const positionManagerABI = [
	`function positions(uint256 tokenId)
    external
    view
    returns (
        uint96 nonce,
        address operator,
        address token0,
        address token1,
        uint24 fee,
        int24 tickLower,
        int24 tickUpper,
        uint128 liquidity,
        uint256 feeGrowthInside0LastX128,
        uint256 feeGrowthInside1LastX128,
        uint128 tokensOwed0,
        uint128 tokensOwed1
    )`
];

const getPrice = async (poolAddress, deltaDecimals = 0n, invert = true) => {
	const pool = new ethers.Contract(poolAddress, poolABI, provider);
	const { sqrtPriceX96 } = await pool.slot0();
	const price =
		Number(
			sqrtPriceX96
				.pow(2)
				.div(10n ** deltaDecimals)
				.mul('1' + '0'.repeat(18))
				.div(ethers.BigNumber.from(2).pow(192))
				.toString()
		) / 1e18;
	return invert ? 1 / price : price;
};

export const ethUsdPool = '0x88e6A0c2dDD26FEEb64F039a2c41296FcB3f5640';
export const inpulseXPool = '0x829336b1d7828fa3ad990dbb6e735bba61c401df';
export const positionManagerAddr = '0xC36442b4a4522E871399CD717aBDD847Ab11FE88';

export const getEthUSDPrice = async () => {
	const ethUsdPrice = await getPrice(ethUsdPool, 12n);
	return ethUsdPrice;
};

export const getIpxUSDPrice = async () => {
	const ipxEthPrice = await getPrice(inpulseXPool);
	const ethUsdPrice = await getPrice(ethUsdPool, 12n);
	const ipxUsdPrice = ipxEthPrice * ethUsdPrice;
	return ipxUsdPrice;
};

export const getIpxEthPrice = async () => {
	const ipxEthPrice = await getPrice(inpulseXPool);
	return ipxEthPrice;
};

export const getIpxLpPriceInEth = async (tokenId) => {
	const pool = new ethers.Contract(inpulseXPool, poolABI, provider);
	const positionManager = new ethers.Contract(positionManagerAddr, positionManagerABI, provider);
	const { tick } = await pool.slot0();
	const { token0, token1, fee, tickLower, tickUpper, liquidity } =
		positionManager.positions(tokenId);
};
