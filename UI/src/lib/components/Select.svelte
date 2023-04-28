<script>
	import Paragraph from './Paragraph.svelte';

	export let value = '';
	export let placeholder = 'Select one';
	export let label = '';
	export let options = [];
	export let column = false;
	export let primary = false;
</script>

<label class:column>
	<Paragraph>{label}</Paragraph>
	<select class:primary bind:value>
		<option value="">{placeholder}</option>
		{#each options as option}
			<option value={option.value} selected={value === option.value}>{option.title}</option>
		{/each}
	</select>
</label>

<style>
	label {
		position: relative;
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

	select {
		box-sizing: border-box;
		padding: 1em 1em;
		padding-right: 3em;
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
		width: 100%;
		border-radius: 4px;
		cursor: pointer;
		appearance: none;
	}
	label::after {
		content: '▼';
		font-size: 1rem;
		top: 1.5em;
		right: 1.5em;
		position: absolute;
		font-family: 'Courier New', Courier, monospace;
	}
	select.primary {
		border: 2px solid var(--primary-pink);
		box-shadow: 0px 1px 6px 1px rgba(0, 0, 0, 0.5), inset -4px 0px 6px 0px rgba(220, 21, 164, 0.5);
		background: linear-gradient(270deg, rgba(220, 21, 164, 0.5) 0%, rgba(20, 15, 41, 1) 100%);
	}
	label.column select {
		flex: 1;
		margin: 0;
	}
	label.column::after {
		top: 3.5em;
	}
</style>
