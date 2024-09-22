<script>
	import Grid from 'gridjs-svelte';

	export let data = [];
	export let columns = [];

	export let sort = true;
</script>

<Grid {data} {columns} {sort} />

<style global>
	@import 'https://cdn.jsdelivr.net/npm/gridjs/dist/theme/mermaid.min.css';
</style>
