<script>
	import Button from '../Button.svelte';
	import Table from '../Table.svelte';
	import Card from '../Card.svelte';

	import { chainIds, claimPastRequest } from '../../swap';
	import { ethers } from 'ethers';
	import { wallet } from '../../../stores/wallet';
	import toast from 'svelte-french-toast';

	export let swap;
	let claiming;

	const data = [
		{ value: chainIds[swap.fromChain].title, value: 'From Chain' },
		{ value: chainIds[swap.toChain].title, value: 'To Chain' },
		{ value: ethers.utils.formatUnits(swap.amount), value: 'Amount' }
	];

	const claim = async () => {
		claiming = true;
		await claimPastRequest($wallet, swap).catch(() => null);
		claiming = false;
	};
</script>

<Card>
	<div class="past-claim">
		<Table {data} />
		<Button disabled={claiming} on:click={claim}>Claim</Button>
	</div>
</Card>

<style>
	.past-claim {
		display: flex;
		flex-direction: column;
		gap: 1em;
		padding: 1em;
	}
</style>
