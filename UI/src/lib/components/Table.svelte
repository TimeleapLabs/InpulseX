<script>
	export let data = [];
</script>

<div class="table">
	{#each data as item}
		<div class="row">
			<div class="col title">{item.title}</div>
			<div class="col value">{item.value}</div>
		</div>
	{/each}
</div>

<style>
	.table {
		display: flex;
		gap: 0.5em;
		flex-direction: column;
		border: 1px solid rgba(255, 255, 255, 0.1);
		border-radius: 0.5em;
		padding: 1em;
	}
	.row {
		display: grid;
		grid-template-columns: 1fr 1fr;
	}
	.col.title {
		text-transform: uppercase;
		text-align: left;
	}
	.col.value {
		text-align: right;
	}
</style>
