<script>
	import Navbar from '$lib/components/Navbar.svelte';
	import Footer from '$lib/components/home/Footer.svelte';

	import { Toaster } from 'svelte-french-toast';
</script>

<Navbar dashboard={true} />
<div class="wrap">
	<slot />
</div>

<Footer />

<Toaster />

<style>
	.wrap {
		background: #140f29 url(/images/stars.png) no-repeat center center;
		background-size: contain;
	}
</style>
