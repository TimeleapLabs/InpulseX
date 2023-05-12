import Onboard from '@web3-onboard/core';
import walletConnectModule from '@web3-onboard/walletconnect';
import injectedModule from '@web3-onboard/injected-wallets';

const appName = 'InpulseX';

const injected = injectedModule();
const walletConnect = walletConnectModule();

const options = {
	appMetadata: {
		name: appName,
		description: 'InpulseX dApp',
		icon: '/images/logo.shadow.png'
	},
	accountCenter: {
		desktop: {
			enabled: false
		},
		mobile: {
			enabled: false
		}
	},
	chains: [
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
			rpcUrl: 'https://bsc-dataseed.binance.org'
		},
		{
			id: '0x89',
			token: 'MATIC',
			label: 'Polygon',
			rpcUrl: 'https://polygon-rpc.com'
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
			rpcUrl: 'https://api.avax.network/ext/bc/C/rpc'
		}
	],
	wallets: [walletConnect, injected]
};

export const chainToId = {
	binance: '0x61',
	ethereum: '0x1',
	polygon: '0x89',
	avalanche: '0xa86a'
};

export const onboard = Onboard(options);
