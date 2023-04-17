<script>
	export let size = 'small';
	export let centered = false;

	let fontSize = '18px';

	$: if (size === 'small') {
		fontSize = '18px';
	} else if (size === 'medium') {
		fontSize = '22px';
	} else if (size === 'large') {
		fontSize = '30px';
	}
</script>

<p class={$$props.class} class:centered style="--font-size: {fontSize};"><slot /></p>

<style>
	p {
		font-family: 'Groningen';
		font-size: var(--font-size);
		margin: 0;
	}

	.centered {
		text-align: center;
	}
</style>
