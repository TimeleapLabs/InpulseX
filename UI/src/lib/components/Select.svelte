<script>
	export let value = '';
	export let placeholder = 'Select one';
	export let label = '';
	export let options = [];
	export let column = false;
</script>

<label class:column>
	{label}
	<select bind:value>
		<option value="">{placeholder}</option>
		{#each options as option}
			<option value={option.value} selected={value === option.value}>{option.title}</option>
		{/each}
	</select>
</label>

<style>
	label {
		text-transform: uppercase;
		display: flex;
		align-items: center;
		gap: 1em;
		white-space: nowrap;
		position: relative;
	}
	label.column {
		flex-direction: column;
		gap: 0.5em;
		align-items: flex-start;
		font-size: 0.78em;
	}
	label::after {
		content: '▼';
		font-size: 1rem;
		top: 0.75em;
		right: 1em;
		position: absolute;
		font-family: 'Courier New', Courier, monospace;
	}
	select {
		font-size: 1.2rem;
		padding: 0.5em 1em;
		box-sizing: border-box;
		margin: 0 0.5em;
		margin-right: 0;
		background: transparent;
		border-color: #257ee4;
		border-style: inset;
		border-radius: 0.5em;
		border-width: 2px;
		font-weight: 600;
		text-transform: uppercase;
		outline: none;
		transition: all 0.8s ease 0.1s;
		color: #fff;
		width: 100%;
		-webkit-appearance: none;
		appearance: none;
	}
	select:focus {
		border-color: #f307ae;
		color: #fe0;
	}

	label.column select {
		flex: 1;
		margin: 0;
	}
	label.column::after {
		top: 2.5em;
	}
</style>
