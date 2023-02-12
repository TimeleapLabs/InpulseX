<script>
	import { ethers } from 'ethers';
	import abi from '../../abi/staking/contracts/interfaces/IERC721.sol/IERC721.json';
	import { wallet } from '../../../stores/wallet';
	import { Jellyfish } from 'svelte-loading-spinners';

	export let nftId;
	export let address;

	let imageUrl;

	const getImageUrl = async () => {
		const provider = new ethers.providers.Web3Provider($wallet.provider);
		const contract = new ethers.Contract(address, abi, provider);
		const metaUrl = await contract.tokenURI(nftId);
		const res = await fetch(metaUrl);
		const metadata = await res.json();
		imageUrl = metadata.properties.image;
	};

	if ($wallet?.provider) getImageUrl();
</script>

<div class="wrap">
	{#if imageUrl}
		<img src={imageUrl} alt="NFT {nftId} of {address}" />
	{:else}
		<Jellyfish size="60" color="#f307ae" unit="px" duration="4s" />
	{/if}
</div>

<style>
	.wrap {
		width: 64px;
		height: 64px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.wrap img {
		width: 100%;
		height: 100%;
		object-fit: contain;
	}
</style>
