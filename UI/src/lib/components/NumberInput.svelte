<script>
	import Paragraph from './Paragraph.svelte';

	export let value = 0;
	export let placeholder;
	export let label = '';
	export let column = false;
	export let primary = false;
	export let fullWidth = false;
</script>

<label class:column>
	<Paragraph>{label}</Paragraph>
	<input
		class:primary
		class:full-width={fullWidth}
		type="number"
		min="0"
		bind:value
		{placeholder}
	/>
</label>

<style>
	label {
		display: flex;
		align-items: center;
		gap: 1em;
		white-space: nowrap;
	}
	label.column {
		flex-direction: column;
		gap: 0.5em;
		align-items: flex-start;
		font-size: 0.78em;
	}
	input {
		box-sizing: border-box;
		padding: 1em 1em;
		border: 2px solid var(--primary-blue);
		border-radius: 3px;
		box-shadow: 0px 1px 6px 1px rgba(0, 0, 0, 0.5), inset -4px 0px 6px 0px rgba(43, 123, 243, 0.5);
		background-color: rgba(20, 15, 41, 1);
		background: linear-gradient(270deg, rgba(43, 123, 243, 0.5) 0%, rgba(20, 15, 41, 1) 100%);
		color: white;
		outline: none;
		font-family: 'Groningen';
		font-size: 18px;
		margin: 0;
		line-height: 1.4em;
	}
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
		/* display: none; <- Crashes Chrome on hover */
		-webkit-appearance: none;
		margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
	}

	input[type='number'] {
		-moz-appearance: textfield; /* Firefox */
	}
	input.primary {
		border: 2px solid var(--primary-pink);
		box-shadow: 0px 1px 6px 1px rgba(0, 0, 0, 0.5), inset -4px 0px 6px 0px rgba(220, 21, 164, 0.5);
		background: linear-gradient(270deg, rgba(220, 21, 164, 0.5) 0%, rgba(20, 15, 41, 1) 100%);
	}
	input.full-width {
		width: 100%;
	}
	label.column input {
		margin: 0;
		flex: 1;
	}
</style>
