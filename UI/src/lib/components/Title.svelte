<script>
	export let as = 'h1';
	export let centered = false;
</script>

<svelte:element this={as} class:centered><slot /></svelte:element>

<style>
	h1,
	h2,
	h3,
	h4 {
		font-family: 'Bebas';
		margin: 0;
	}

	h1 {
		font-size: 135px;
	}

	h2 {
		font-size: 69px;
	}

	h3 {
		font-size: 34px;
	}

	h4 {
		font-size: 34px;
	}

	.centered {
		text-align: center;
	}
</style>
