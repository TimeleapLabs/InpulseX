import { onboard } from './onboard.js';
import { ethers } from 'ethers';

import toast from 'svelte-french-toast';
import pegswapAbi from '../lib/abi/pegswap/contracts/Swap.sol/Swap.json';
import ipxAbi from '../lib/abi/token/contracts/InpulseX.sol/InpulseX.json';

const pegswapEndpoint = 'https://29q4wlts70.execute-api.us-east-1.amazonaws.com/v1/pegswap';

export const chains = {
	polygon: '0x89',
	//bsc: '0x38',
	bsc: '0x61',
	ethereum: '0x01',
	//avax: '0xa86a'
	avax: '0xa869'
};

export const ipxAddresses = {
	bsc: '0xB5649E0558890EAbd70e018Aaf015cC8242f4C0A',
	polygon: '',
	ethereum: '',
	avax: '0x48afe04958d195C076fBE44b5861aaDA8445673B'
};

export const operatorAddresses = {
	polygon: '0xde81FE66A1A23b9E23e9581361596e66a4b2Ce53',
	bsc: '0xde81FE66A1A23b9E23e9581361596e66a4b2Ce53',
	ethereum: '0xde81FE66A1A23b9E23e9581361596e66a4b2Ce53',
	avax: '0xde81FE66A1A23b9E23e9581361596e66a4b2Ce53'
};

export const pegswapAddresses = {
	bsc: '0xd735FBACD92adf8c1cF20201C6a17F37149301BC',
	polygon: '',
	ethereum: '',
	avax: '0x97E07b516Ef405aE7B3639eae2c034CE855Ffbec'
};

export const chainIds = {
	//'0x38': {
	'0x61': {
		key: 'bsc',
		icon: 'binance',
		title: 'BNB Smart Chain',
		shortTitle: 'BSC'
	},
	'0x89': {
		key: 'polygon',
		icon: 'polygon',
		title: 'Polygon',
		shortTitle: 'MATIC'
	},
	//'0xa86a': {
	'0xa869': {
		key: 'avax',
		icon: 'avalanche',
		title: 'Avalanche',
		shortTitle: 'AVAX'
	},
	'0x01': { key: 'ethereum', icon: 'ethereum', title: 'Ethereum', shortTitle: 'ETH' }
};

export const rpcList = {
	'0x38': 'https://bsc-dataseed.binance.org',
	'0x61': 'https://data-seed-prebsc-1-s1.binance.org:8545',
	'0x89': 'https://polygon-rpc.com',
	'0x01': 'https://eth.llamarpc.com',
	'0xa86a': 'https://api.avax.network/ext/bc/C/rpc',
	'0xa869': 'https://api.avax-test.network/ext/bc/C/rpc'
};

export const pegswapNonceQuery = (operator, toChain, nonce) => `{
    getEntries(operator: "${operator}", toChain: "${toChain}", nonce: "${nonce}") {
      signature
      request {
        fromChain
        toChain
        operator
        recipient
        amount
        nonce
      }
    }
  }`;

const hexZeroPad = (hex) => (hex.length % 2 ? hex.replace(/^0x/, '0x0') : hex);
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

class Deferred {
	constructor() {
		this.promise = new Promise((resolve, reject) => {
			this.reject = reject;
			this.resolve = resolve;
		});
	}
}

export const waitForNonceAndClaim = async ($wallet, operator, toChain, nonce) => {
	const paddedChain = hexZeroPad(toChain);
	const paddedNonce = hexZeroPad(nonce.toHexString());
	const query = pegswapNonceQuery(operator, paddedChain, paddedNonce);
	let entry;

	const oracleJob = new Deferred();

	toast.promise(oracleJob.promise, {
		loading: 'Waiting for the oracle',
		success: 'Swap request accepted',
		error: 'Something went wrong!'
	});

	try {
		while (!entry) {
			const response = await fetch(pegswapEndpoint, {
				method: 'POST',
				body: JSON.stringify({ query })
			});
			const { data: { getEntries } = {} } = (await response.json()) || {};
			if (getEntries && getEntries.length) {
				entry = getEntries[0];
				break;
			}
			await sleep(2500);
		}
	} catch (error) {
		oracleJob.reject(error);
		throw error;
	}

	oracleJob.resolve();

	await toast.promise(
		onboard.setChain({
			chainId: entry.request.toChain.replace(/^0x0+/, '0x')
		}),
		{
			loading: 'Switching to the destination chain',
			success: 'Switched to the destination chain',
			error: 'Unable to switch network!'
		}
	);

	await toast.promise(claim($wallet, entry), {
		loading: 'Claiming from the destination chain',
		success: 'Successfully claimed!',
		error: 'Failed to claim your swap request!'
	});
};

const getErrorMessage = (error) => {
	console.trace(error);
	return (
		error.data?.message?.match(/PegSwap: (.*)/)?.pop() ||
		error.data?.message?.replace(/execution reverted: /, '') ||
		error.data?.message ||
		'Something went wrong!'
	);
};

const claim = async ($wallet, { request, signature }) => {
	const provider = new ethers.providers.Web3Provider($wallet.provider);
	const signer = provider.getSigner();
	const pegswapAddr = pegswapAddresses[chainIds[request.toChain].key];
	const pegswap = new ethers.Contract(pegswapAddr, pegswapAbi, provider);
	try {
		const { v, r, s } = ethers.utils.splitSignature(signature);
		const tx = await pegswap.connect(signer).claim(request, v, r, s);
		await tx.wait(1);
		toast.success('Claimed successfully.');
	} catch (error) {
		toast.error(getErrorMessage(error));
	}
};

export const claimPastRequest = async ($wallet, { request, signature }) => {
	await onboard.setChain({
		chainId: request.toChain.replace(/^0x0+/, '0x')
	});
	await claim($wallet, { request, signature });
};

export const pegswapRecipientQuery = (recipient) => `{
    getEntries(recipient: "${recipient}") {
      signature
      request {
        fromChain
        toChain
        operator
        recipient
        amount
        nonce
      }
    }
  }`;

const isClaimed = async (request) => {
	const rpcUrl = rpcList[request.toChain];
	const provider = new ethers.providers.JsonRpcProvider(rpcUrl);
	const pegswapAddr = pegswapAddresses[chainIds[request.toChain].key];
	const pegswap = new ethers.Contract(pegswapAddr, pegswapAbi, provider);
	return await pegswap.isClaimed(request.fromChain, request.nonce);
};

export const getUserRequests = async ($wallet) => {
	const recipient = $wallet?.accounts?.[0]?.address;
	if (recipient) {
		const query = pegswapRecipientQuery(ethers.utils.getAddress(recipient));
		const response = await fetch(pegswapEndpoint, {
			method: 'POST',
			body: JSON.stringify({ query })
		});

		const { data: { getEntries } = {} } = (await response.json()) || {};
		const userRequests = getEntries || [];
		const pending = [];

		for (const entry of userRequests) {
			const claimed = await isClaimed(entry.request);
			if (!claimed) pending.push(entry);
		}

		return pending;
	}
};

const parseLog = (ipx, pegswap) => (log) => {
	try {
		return ipx.interface.parseLog(log);
	} catch (error) {
		// Do nothing
	}
	try {
		return pegswap.interface.parseLog(log);
	} catch (error) {
		// Do nothing
	}
};

export const requestSwap = async ($wallet, sourceChain, destChain, amount) => {
	await toast.promise(onboard.setChain({ chainId: chains[sourceChain] }), {
		loading: 'Switching to the source chain',
		success: 'Switched to the source chain',
		error: 'Unable to switch network!'
	});

	const provider = new ethers.providers.Web3Provider($wallet.provider);
	const ipxAddr = ipxAddresses[sourceChain];
	const pegswapAddr = pegswapAddresses[sourceChain];
	const kenshi = new ethers.Contract(ipxAddr, ipxAbi, provider);
	const pegswap = new ethers.Contract(pegswapAddr, pegswapAbi, provider);
	try {
		const signer = provider.getSigner();
		const parsedAmount = ethers.utils.parseUnits(amount.toString());
		const data = ethers.utils.defaultAbiCoder.encode(
			['uint256', 'address'],
			[chains[destChain], operatorAddresses[destChain]]
		);

		const tx = await toast.promise(
			kenshi
				.connect(signer)
				['transferAndCall(address,uint256,bytes)'](pegswapAddr, parsedAmount, data),
			{
				loading: 'Sending your swap request',
				success: 'Swap request sent',
				error: 'Something went wrong!'
			}
		);

		const receipt = await toast.promise(tx.wait(1), {
			loading: 'Waiting for the transaction',
			success: 'Transaction confirmed',
			error: 'Something went wrong!'
		});

		const logs = receipt.logs.map(parseLog(kenshi, pegswap));
		const { nonce } = logs.filter((log) => log?.name === 'SwapRequested').pop().args;

		await waitForNonceAndClaim($wallet, operatorAddresses[destChain], chains[destChain], nonce);
	} catch (error) {
		// Do nothing
	}
};
