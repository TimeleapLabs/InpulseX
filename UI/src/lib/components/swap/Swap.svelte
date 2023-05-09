<script>
	import RequestSwap from './RequestSwap.svelte';
	import PastClaim from './PastClaim.svelte';

	import { getUserRequests } from '../../swap.js';
	import { wallet } from '../../../stores/wallet';
	import { onMount } from 'svelte';

	let userRequests = [];

	const fetchUserRequests = async () => {
		if (!$wallet?.provider) {
			return;
		}
		userRequests = await getUserRequests($wallet);
	};

	$: if ($wallet?.provider) fetchUserRequests();

	onMount(() => {
		const timeout = setTimeout(fetchUserRequests, 20000);
		return () => {
			clearTimeout(timeout);
		};
	});
</script>

<div class="swap">
	<RequestSwap />
</div>

{#if userRequests.length}
	<h2>Pending Swaps</h2>
	<div class="past-swaps">
		{#each userRequests as swap}
			<PastClaim {swap} />
		{/each}
	</div>
{/if}

<style>
	.past-swaps {
		display: flex;
		gap: 1em;
		flex-wrap: wrap;
	}
	.swap {
		display: flex;
		width: 580px;
		max-width: 100%;
	}
	h2 {
		margin-top: 2em;
	}
</style>
