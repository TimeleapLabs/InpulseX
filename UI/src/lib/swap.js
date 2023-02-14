import { onboard } from './onboard.js';
import { ethers } from 'ethers';

import toast from 'svelte-french-toast';
import pegswapAbi from '../lib/abi/pegswap/contracts/Swap.sol/Swap.json';
import ipxAbi from '../lib/abi/token/contracts/InpulseX.sol/InpulseX.json';

const pegswapEndpoint = '';

export const chains = {
	polygon: '0x89',
	bsc: '0x38',
	ethereum: '0x01',
	avax: '0xa86a'
};

export const ipxAddresses = {
	bsc: '0x42f9c5a27a2647a64f7D3d58d8f896C60a727b0f',
	polygon: '0x164caf66c45e483F7eE647CcaD275B35B4C75719',
	ethereum: '0x164caf66c45e483F7eE647CcaD275B35B4C75719',
	avax: '0x164caf66c45e483F7eE647CcaD275B35B4C75719'
};

export const operatorAddresses = {
	polygon: '0x855C83A8d3C5BDE6A505cdFEB8272b8F47Bd3213',
	bsc: '0x855C83A8d3C5BDE6A505cdFEB8272b8F47Bd3213',
	ethereum: '0x855C83A8d3C5BDE6A505cdFEB8272b8F47Bd3213',
	avax: '0x855C83A8d3C5BDE6A505cdFEB8272b8F47Bd3213'
};

export const pegswapAddresses = {
	bsc: '0x3CcAa188Dd35E9125D7ade476da123C020aeC84d',
	polygon: '0x8AdA51404F297bF2603912d1606340223c0a7784',
	ethereum: '0x8AdA51404F297bF2603912d1606340223c0a7784',
	avax: '0x8AdA51404F297bF2603912d1606340223c0a7784'
};

export const chainIds = {
	'0x38': {
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
	'0xa86a': {
		key: 'avax',
		icon: 'avalanche',
		title: 'Avalanche',
		shortTitle: 'AVAX'
	},
	'0x01': { key: 'ethereum', icon: 'ethereum', title: 'Ethereum', shortTitle: 'ETH' }
};

export const rpcList = {
	'0x38': 'https://bsc-dataseed.binance.org',
	'0x89': 'https://polygon-rpc.com',
	'0x01': 'https://eth.llamarpc.com',
	'0xa86a': 'https://api.avax.network/ext/bc/C/rpc'
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

export const waitForNonceAndClaim = async (operator, toChain, nonce) => {
	const paddedChain = hexZeroPad(toChain);
	const paddedNonce = hexZeroPad(nonce.toHexString());
	const query = pegswapNonceQuery(operator, paddedChain, paddedNonce);
	let entry;

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

	await toast.promise(claim(entry, true), {
		loading: 'Claiming from the destination chain',
		success: 'Successfully claimed!',
		error: 'Failed to claim your swap request!'
	});
};

const getErrorMessage = (error) => {
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

		const pendingRequests = pending.map((req, id) => ({
			...req.request,
			actions: {
				signature: req.signature,
				request: req.request
			},
			id
		}));

		return pendingRequests;
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
		loading: 'Switching to the destination chain',
		success: 'Switched to the destination chain',
		error: 'Unable to switch network!'
	});

	toast('Sending your swap request', { icon: '⏳' });

	const provider = new ethers.providers.Web3Provider($wallet.provider);
	const ipxAddr = ipxAddresses[sourceChain];
	const pegswapAddr = pegswapAddresses[sourceChain];
	const kenshi = new ethers.Contract(ipxAddr, ipxAbi, provider);
	const pegswap = new ethers.Contract(pegswapAddr, pegswapAbi, provider);
	try {
		const signer = provider.getSigner();
		const parsedAmount = ethers.utils.parseUnits(amount);
		const data = ethers.utils.defaultAbiCoder.encode(
			['uint256', 'address'],
			[chains[destChain], operatorAddresses[destChain]]
		);

		const tx = await kenshi
			.connect(signer)
			['transferAndCall(address,uint256,bytes)'](pegswapAddr, parsedAmount, data);

		toast('Waiting for the transaction', { icon: '⏳' });

		const receipt = await tx.wait(1);
		const logs = receipt.logs.map(parseLog(kenshi, pegswap));
		const { nonce } = logs.filter((log) => log?.name === 'SwapRequested').pop().args;

		toast('Waiting for the oracle', { icon: '⏳' });

		await waitForNonceAndClaim(operatorAddresses[destChain], chains[destChain], nonce);
	} catch (error) {
		toast.error(getErrorMessage(error));
	}
};
