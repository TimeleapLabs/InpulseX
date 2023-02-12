<script>
	import { wallet } from '../../../stores/wallet';
	import { ethers } from 'ethers';

	import abi from '../../abi/staking/contracts/utils/NFTSweep.sol/NFTSweep.json';
	import View from './View.svelte';

	export let address;
	export let maxMinted;
	export let bucketSize = 250;
	export let selected = {};

	let userNfts = [];

	const sweeperAddress = '0x039976F40a15Bbaaf055144d59F0a47341AF2dcb';

	const fetchEnumerable = async (contract, address, user) => {
		try {
			const NFTs = await contract.performEnumerableNftSweep(address, user);
			return NFTs;
		} catch (error) {
			return [];
		}
	};

	const fetchUserNFTs = async () => {
		const provider = new ethers.providers.Web3Provider($wallet.provider);
		const contract = new ethers.Contract(sweeperAddress, abi, provider);
		const user = $wallet.accounts[0].address;
		const sweepedNfts = await fetchEnumerable(contract, address, user);

		if (!sweepedNfts.length) {
			let start = ethers.BigNumber.from(0);
			while (start < maxMinted) {
				const [found, paginate] = await contract.performNftSweep(
					address,
					user,
					start,
					ethers.BigNumber.from(maxMinted).gt(start.add(bucketSize))
						? start.add(bucketSize)
						: ethers.BigNumber.from(maxMinted)
				);
				if (found.length) {
					sweepedNfts.push(...found.map((id) => id.toString()).filter((id) => id !== '0'));
				}
				start = paginate;
			}
		}

		userNfts = sweepedNfts;
	};

	$: if ($wallet?.provider) fetchUserNFTs();
</script>

<div class="nfts">
	{#each userNfts as nftId}
		<label class="nft-select" class:selected={selected[nftId]}>
			<View {address} {nftId} />
			<input type="checkbox" bind:checked={selected[nftId]} />
		</label>
	{/each}
</div>

<style>
	.nfts {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 0.5em;
		flex-wrap: wrap;
	}
	.nft-select {
		border-radius: 0.5em;
		border: 1px solid rgba(255, 255, 255, 0.1);
		padding: 0.5em;
	}
	.nft-select.selected {
		border-color: #257ee4;
	}
	input {
		display: none;
	}
</style>
