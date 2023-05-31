<script>
	import Card from '../Card.svelte';
	import { DateTime } from 'luxon';
	import Title from '../Title.svelte';
	import Countup from 'svelte-countup';

	export let userApy;
	export let start;
	export let units;

	const { days } = DateTime.now().diff(DateTime.fromJSDate(start), 'days');

	let rewards;
	$: rewards = userApy * days;
</script>

<Card>
	<div class="inner">
		<Title as="h3">Estimated earned rewards</Title>
		<div class="reward">
			<span class="count">
				<Countup value={rewards} />
			</span>
			{units}
		</div>
	</div>
</Card>

<style>
	.inner {
		position: relative;
		z-index: 1;
		width: 100%;
		height: auto;
		z-index: 1;
		margin: 0 auto;
		max-width: 100%;
		padding: 1em;
		box-sizing: border-box;
		text-align: center;
		display: flex;
		flex-direction: column;
		gap: 1em;
	}
	.inner :global(h3) {
		margin-bottom: 1em;
	}
	.count {
		font-size: 4em;
	}
</style>
