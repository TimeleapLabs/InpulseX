<script>
	import ConnectButton from '../lib/components/ConnectButton.svelte';
	import ERC1363Stake from '../lib/components/staking/ERC1363Stake.svelte';
	import Swap from '../lib/components/swap/Swap.svelte';

	import { Toaster } from 'svelte-french-toast';

	const data = [
		{ title: 'Your stake', value: '123456 IPX' },
		{ title: 'Reward', value: '123 BUSD' }
	];

	const options = [
		{ title: 'BSC', value: 'bsc' },
		{ title: 'Ethereum', value: 'ethereum' }
	];
</script>

<div class="connect">
	<ConnectButton />
</div>

<div class="stake">
	<ERC1363Stake
		title="Stake IPX"
		address="0xf24426Ba23571a046E15Ae49A6088Db5f60E7ac3"
		rewardSymbol="IPX"
	/>
</div>
<div class="swap">
	<Swap />
</div>
<Toaster />

<style>
	:global(body) {
		background: #111;
		color: #fff;
		font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu,
			Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	}
	.connect,
	.stake {
		display: flex;
		padding: 1em 2em;
	}
	.swap {
		padding: 1em 2em;
	}
</style>
