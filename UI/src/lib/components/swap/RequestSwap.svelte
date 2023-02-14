<script>
	import { chainIds, requestSwap } from '../../swap.js';
	import { wallet } from '../../../stores/wallet.js';
	import { ethers } from 'ethers';
	import toast from 'svelte-french-toast';

	import NumberInput from '../NumberInput.svelte';
	import Select from '../Select.svelte';
	import Card from '../Card.svelte';
	import Button from '../Button.svelte';

	let fromChain;
	let toChain;
	let amount;
	let requesting;

	const chainOptions = Object.values(chainIds).map((chain) => ({
		value: chain.key,
		title: chain.title
	}));

	$: if (fromChain === toChain) {
		toChain = chainOptions.filter((option) => option.value !== fromChain)[0].value;
	}

	const request = async () => {
		if (ethers.BigNumber.from(amount).eq(0)) {
			return toast.error('Amount needs to be bigger than 0');
		}
		requesting = true;
		await requestSwap($wallet, fromChain, toChain, amount).catch(() => null);
		requesting = false;
	};
</script>

<Card>
	<div class="swap">
		<h4>IPX PegSwap</h4>
		<Select column options={chainOptions} bind:value={fromChain} label="From chain" />
		<Select
			column
			options={chainOptions.filter((option) => option.value !== fromChain)}
			bind:value={toChain}
			label="To chain"
		/>
		<NumberInput column label="Amount" bind:value={amount} />
		<Button disabled={requesting} on:click={request}>Swap</Button>
	</div>
</Card>

<style>
	h4 {
		margin: 0;
	}
	.swap {
		display: flex;
		gap: 1em;
		flex-direction: column;
		padding: 1em;
	}
</style>
