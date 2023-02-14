<script>
	import Button from '../Button.svelte';
	import Table from '../Table.svelte';
	import Card from '../Card.svelte';

	import { chainIds } from '../../swap';
	import { ethers } from 'ethers';

	export let swap;

	const data = [
		{ value: chainIds[swap.fromChain].title, value: 'From Chain' },
		{ value: chainIds[swap.toChain].title, value: 'To Chain' },
		{ value: ethers.utils.formatUnits(swap.amount), value: 'Amount' }
	];
</script>

<Card>
	<div class="past-claim">
		<Table {data} />
		<Button>Claim</Button>
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
