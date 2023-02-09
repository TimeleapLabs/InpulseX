<script>
	export let value = 0;
	export let placeholder;
	export let label = '';
</script>

<label>
	{label}
	<input type="number" min="0" bind:value {placeholder} />
</label>

<style>
	label {
		text-transform: uppercase;
		display: flex;
		align-items: center;
		gap: 1em;
		white-space: nowrap;
	}
	input {
		font-size: 1.2rem;
		padding: 0.5em 1em;
		margin: 0 0.5em;
		margin-right: 0;
		background: transparent;
		border-color: #257ee4;
		border-style: inset;
		border-radius: 0.5em;
		font-weight: 600;
		text-transform: uppercase;
		outline: none;
		transition: all 0.8s ease 0.1s;
		color: #fff;
		width: 100%;
	}
	input:focus {
		border-color: #f307ae;
		color: #fe0;
	}
</style>
