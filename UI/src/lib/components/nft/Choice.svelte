<script>
	import { wallet } from '../../../stores/wallet';
	import { ethers } from 'ethers';

	import abi from '../../abi/staking/contracts/utils/NFTSweep.sol/NFTSweep.json';
	import View from './View.svelte';

	export let address;
	export let maxMinted;
	export let bucketSize = 100;

	let userNfts = [];

	const sweeperAddress = '';

	const fetchUserNFTs = async () => {
		const provider = new ethers.providers.Web3Provider($wallet.provider);
		const contract = new ethers.Contract(sweeperAddress, abi, provider);
		const user = $wallet.accounts[0].address;
		const sweepedNfts = [];
		let start = 0;
		while (start < maxMinted) {
			const found = await contract.performNftSweep(
				address,
				user,
				start,
				Math.min(maxMinted, start + bucketSize)
			);
			if (found.length) sweepedNfts.push(...found);
			start += bucketSize;
		}
		userNfts = sweepedNfts;
	};

	if ($wallet?.provider) fetchUserNFTs();
</script>

{#each userNfts as nftId}
	<View {address} {nftId} />
{/each}
