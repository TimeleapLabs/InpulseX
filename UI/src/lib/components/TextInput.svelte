<script>
	export let value;
	export let placeholder;
</script>

<input type="text" bind:value {placeholder} />

<style>
	input {
		font-size: 1.2rem;
		padding: 10px 16px;
		margin: 0 10px;
		background: transparent;
		border-color: #257ee4;
		border-style: inset;
		border-radius: 8px;
		font-weight: 600;
		text-transform: uppercase;
		outline: none;
		transition: all 0.8s ease 0.1s;
		color: #fff;
	}
	input:focus {
		border-color: #f307ae;
		color: #fe0;
	}
</style>
