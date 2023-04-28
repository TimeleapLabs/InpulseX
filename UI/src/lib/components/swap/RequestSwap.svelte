<script>
	import { chainIds, requestSwap } from '../../swap.js';
	import { wallet } from '../../../stores/wallet.js';
	import { ethers } from 'ethers';
	import toast from 'svelte-french-toast';

	import NumberInput from '../NumberInput.svelte';
	import Select from '../Select.svelte';
	import Card from '../Card.svelte';
	import Button from '../Button.svelte';
	import FancyButton from '../FancyButton.svelte';
	import Title from '../Title.svelte';

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

<Card fullWidth>
	<div class="swap">
		<Title as="h3">IPX PegSwap</Title>
		<Select column options={chainOptions} bind:value={fromChain} label="From chain" primary />
		<Select
			column
			options={chainOptions.filter((option) => option.value !== fromChain)}
			bind:value={toChain}
			label="To chain"
			primary
		/>
		<NumberInput column primary label="Amount" bind:value={amount} />
		<FancyButton disabled={requesting} primary on:click={request}>Swap</FancyButton>
	</div>
</Card>

<style>
	.swap {
		display: flex;
		gap: 1em;
		flex-direction: column;
		padding: 1em;
	}
</style>
