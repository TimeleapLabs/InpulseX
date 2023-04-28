<script>
	export let isPrimary = true;
	export let fullWidth = false;
</script>

<div class="card" class:full-width={fullWidth} class:primary={isPrimary}>
	<slot />
</div>

<style>
	.card {
		padding: 1em;
		border-radius: 0.5em;
		border: 2px solid var(--primary-blue);
		box-shadow: -1px 2px 15px 1px var(--primary-blue);
		background: linear-gradient(315deg, rgba(43, 123, 243, 0.5) 50%, rgba(20, 15, 41, 1) 100%);
	}

	.card.full-width {
		width: 100%;
	}

	.card.primary {
		border: 2px solid var(--primary-pink);
		box-shadow: -1px 2px 15px 1px var(--primary-pink);
		background: linear-gradient(315deg, rgba(220, 21, 164, 0.5) 50%, rgba(20, 15, 41, 1) 100%);
	}
</style>
