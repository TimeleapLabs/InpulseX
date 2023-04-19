<script>
	export let as = 'h1';
	export let centered = false;
</script>

<svelte:element this={as} class={$$props.class} class:centered><slot /></svelte:element>

<style>
	h1,
	h2,
	h3,
	h4 {
		font-family: 'Bebas';
		margin: 0;
	}

	h1 {
		font-size: 4em;
	}

	h2 {
		font-size: 3em;
	}

	h3 {
		font-size: 2em;
	}

	h4 {
		font-size: 1em;
	}

	.centered {
		text-align: center;
	}
</style>
