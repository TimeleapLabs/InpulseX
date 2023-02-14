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

<RequestSwap />

<div class="past-swaps">
	{#each userRequests as swap}
		<PastClaim {swap} />
	{/each}
</div>
