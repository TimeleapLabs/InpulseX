<script>
	import Navbar from '$lib/components/Navbar.svelte';
	import Footer from '$lib/components/home/Footer.svelte';

	import { Toaster } from 'svelte-french-toast';

	import Swap from '../../lib/components/dashboard/Swap.svelte';
	import Stake from '../../lib/components/dashboard/Stake.svelte';
</script>

<Navbar dashboard={true} />
<div class="wrap">
	<Swap />
	<Stake />
</div>
<Footer />

<Toaster />

<style>
	.wrap {
		background: #140f29 url(/images/stars.png) no-repeat center center;
		background-size: contain;
	}
</style>
