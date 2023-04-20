<script>
	export let fullWidth;
	export let disabled;
	export let href = '';
</script>

{#if href}
	<a {href} class:full-width={fullWidth} on:click {...$$restProps}><slot /></a>
{:else}
	<button class:full-width={fullWidth} on:click {disabled}><slot /></button>
{/if}

<style>
	a {
		display: block;
		text-decoration: none;
	}
	a,
	button {
		font-size: 1.2rem;
		padding: 0.5em 1em;
		background: radial-gradient(#257ee4 30%, #104e95);
		border: none;
		border-radius: 0.5em;
		font-weight: 600;
		font-family: 'Groningen';
		color: #fff;
	}
	.full-width {
		width: 100%;
	}
	a:hover,
	button:hover {
		transform: scale(1.04) translateY(-2px);
		transition: color 0.8s ease 0.1s;
	}
	a:active,
	button:active {
		transform: scale(0.99) translateY(2px);
	}
</style>
