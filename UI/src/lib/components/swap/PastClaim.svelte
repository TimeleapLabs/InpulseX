<script>
	import Button from '../Button.svelte';
	import Table from '../Table.svelte';
	import Card from '../Card.svelte';

	import { chainIds, claimPastRequest } from '../../swap';
	import { ethers } from 'ethers';
	import { wallet } from '../../../stores/wallet';

	export let swap;

	let claimed = false;
	let claiming;

	const data = [
		{ value: chainIds[swap.request.fromChain].title, title: 'From Chain' },
		{ value: chainIds[swap.request.toChain].title, title: 'To Chain' },
		{ value: ethers.utils.formatUnits(swap.request.amount), title: 'Amount' },
		{ value: ethers.BigNumber.from(swap.request.nonce).toString(), title: 'Request ID' }
	];

	const claim = async () => {
		claiming = true;
		await claimPastRequest($wallet, swap).catch(() => null);
		claiming = false;
		claimed = true;
	};
</script>

{#if !claimed}
	<Card>
		<div class="past-claim">
			<Table {data} />
			<Button disabled={claiming} on:click={claim}>Claim</Button>
		</div>
	</Card>
{/if}

<style>
	.past-claim {
		display: flex;
		flex-direction: column;
		gap: 1em;
		padding: 1em;
	}
</style>
