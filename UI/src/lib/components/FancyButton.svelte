<script>
	import Paragraph from './Paragraph.svelte';

	export let primary = false;
	export let fullWidth = false;
	export let disabled = false;
</script>

<button on:click {disabled} class:primary class:full-width={fullWidth}>
	<span><Paragraph><slot /></Paragraph></span>
</button>

<style>
	button {
		box-sizing: border-box;
		padding: 1em 1em;
		border: 2px solid var(--primary-blue);
		border-radius: 4px;
		box-shadow: 0px 1px 6px 1px rgba(0, 0, 0, 0.5), inset -4px 0px 6px 0px rgba(43, 123, 243, 0.5);
		background-color: rgba(20, 15, 41, 1);
		background: linear-gradient(270deg, rgba(43, 123, 243, 0.5) 0%, rgba(20, 15, 41, 1) 100%);
		cursor: pointer;
	}

	button span {
		color: white;
		opacity: 1;
	}

	button:disabled {
		cursor: not-allowed;
		pointer-events: none;
	}

	button:disabled span {
		color: white;
		opacity: 0.5;
	}

	button.primary {
		border: 2px solid var(--primary-pink);
		box-shadow: 0px 1px 6px 1px rgba(0, 0, 0, 0.5), inset -4px 0px 6px 0px rgba(220, 21, 164, 0.5);
		background: linear-gradient(270deg, rgba(220, 21, 164, 0.5) 0%, rgba(20, 15, 41, 1) 100%);
	}

	button.full-width {
		width: 100%;
	}

	button:hover {
		background: linear-gradient(90deg, rgba(43, 123, 243, 0.5) 0%, rgba(43, 123, 243, 0) 100%);
	}

	button:active {
		box-shadow: inset -4px 0px 6px 0px rgba(43, 123, 243, 0.5);
	}

	button.primary:active {
		box-shadow: inset -4px 0px 6px 0px rgba(220, 21, 164, 0.5);
	}

	button.primary:hover {
		background: linear-gradient(90deg, rgba(220, 21, 164, 0.5) 0%, rgba(220, 21, 164, 0) 100%);
	}
</style>
