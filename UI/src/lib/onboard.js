import Onboard from '@web3-onboard/core';
import walletConnectModule from '@web3-onboard/walletconnect';
import injectedModule from '@web3-onboard/injected-wallets';
import { icon } from './icon';

const appName = 'InpulseX';

const walletConnectProjectId = '72d140c2ce114e0d26a288940936ccd9';

const injected = injectedModule();

const walletConnect = walletConnectModule({
	projectId: walletConnectProjectId,
	requiredChains: [0x1, 0x38]
});

export const publicRpcs = {
	binance: 'https://bsc-dataseed.binance.org',
	ethereum: 'https://eth.llamarpc.com',
	polygon: 'https://rpc-mumbai.matic.today',
	avalanche: 'https://api.avax.network/ext/bc/C/rpc'
};

const chains = [
	{
		id: '0x61',
		token: 'BNB',
		label: 'BNB Smart Chain Testnet',
		rpcUrl: 'https://data-seed-prebsc-1-s1.binance.org:8545'
	},
	{
		id: '0x1',
		token: 'Ethereum',
		label: 'Ethereum',
		rpcUrl: 'https://eth.llamarpc.com'
	},
	{
		id: '0x38',
		token: 'BNB',
		label: 'BNB Smart Chain',
		rpcUrl: publicRpcs.binance
	},
	// {
	// 	id: '0x89',
	// 	token: 'MATIC',
	// 	label: 'Polygon',
	// 	rpcUrl: 'https://polygon-rpc.com'
	// },
	{
		id: '0x13881',
		token: 'MATIC',
		label: 'Polygon',
		rpcUrl: publicRpcs.polygon
	},
	{
		id: '0xa869',
		token: 'AVAX',
		label: 'Avalanche Fuji C-Chain',
		rpcUrl: 'https://api.avax-test.network/ext/bc/C/rpc'
	},
	{
		id: '0xa86a',
		token: 'AVAX',
		label: 'Avalanche C-Chain',
		rpcUrl: publicRpcs.avalanche
	}
];

const options = {
	appMetadata: {
		name: appName,
		description: 'InpulseX dApp',
		icon
	},
	accountCenter: {
		desktop: {
			enabled: false
		},
		mobile: {
			enabled: false
		}
	},
	chains,
	wallets: [walletConnect, injected]
};

export const chainToId = {
	binance: '0x38',
	ethereum: '0x1',
	//polygon: '0x89',
	polygon: '0x13881',
	avalanche: '0xa86a'
};

export const onboard = Onboard(options);
