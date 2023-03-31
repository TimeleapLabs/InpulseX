<script>
	export let data = [];
</script>

<div class="table">
	{#each data as item}
		<div class="row" class:has-icon={item.icon}>
			<div class="col title">{item.title}</div>
			<div class="col value">{item.value}</div>
			{#if item.icon}
				<div class="col icon">
					<img src={item.icon} alt="Icon" />
				</div>
			{/if}
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
	.row.has-icon {
		grid-template-columns: 1fr 1fr 2em;
	}
	.col.title {
		text-transform: uppercase;
		text-align: left;
	}
	.col.value {
		text-align: right;
	}
	.col.icon {
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.col.icon img {
		height: 1em;
	}
</style>
