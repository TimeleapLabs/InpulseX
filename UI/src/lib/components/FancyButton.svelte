<script>
	import Paragraph from './Paragraph.svelte';
	import { Confetti } from 'svelte-confetti';

	export let primary = false;
	export let fullWidth = false;
	export let disabled = false;
	export let confetti = false;
</script>

<button on:click {disabled} class:primary class:full-width={fullWidth}>
	<span><Paragraph><slot /></Paragraph></span>
	{#if confetti}
		<div class="confetti">
			<Confetti x={[-0.5, 0.5]} />
			<Confetti amount="10" x={[-0.75, -0.3]} y={[0.15, 0.75]} />
			<Confetti amount="10" x={[0.3, 0.75]} y={[0.15, 0.75]} />
		</div>
	{/if}
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
		position: relative;
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

	.confetti {
		width: 2px;
		height: 2px;
		left: 50%;
		top: 50%;
		transform: translateX(-50%) translateY(-50%);
		position: absolute;
	}
</style>
