<script>
	import Navbar from '../../lib/components/Navbar.svelte';
	import Dashboard from '../../lib/components/dashboard/Dashboard.svelte';
	import Footer from '../../lib/components/home/Footer.svelte';

	import { Toaster } from 'svelte-french-toast';
</script>

<Navbar />
<Dashboard />
<Footer />

<!-- <div class="connect">
	<ConnectButton />
</div>

<div class="stake">
	<ERC1363Stake
		title="Stake IPX"
		start={new Date('2023-03-31T18:22:07.831Z')}
		address="0xb7D3C2825866D8523bE8B8aa4ad0eAbADc34B580"
		rewardSymbol="GC"
		rewardLogo="https://pools.outerringmmo.com/assets/images/gq.png"
		stakeLogo="https://pools.outerringmmo.com/assets/images/IPX.png"
	/>
</div>
<div class="swap">
	<Swap />
</div> -->
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
