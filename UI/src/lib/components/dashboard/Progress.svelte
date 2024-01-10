<script>
	import Card from '../Card.svelte';
	import { DateTime } from 'luxon';
	import Title from '../Title.svelte';
	import Countup from 'svelte-countup';

	export let start;
	export let unlockTime;

	let daysPassed, daysLeft, daysTotal, percent;

	$: if (start && unlockTime) {
		daysPassed = DateTime.now().diff(DateTime.fromJSDate(start), 'days').days;
		daysLeft = DateTime.fromMillis(unlockTime).diff(DateTime.now(), 'days').days;
		daysTotal = daysPassed + daysLeft;
		percent = (daysPassed / daysTotal) * 100;
	}
</script>

<Card>
	<div class="inner">
		<Title as="h3">Pool progress</Title>
		{#key percent}
			<div class="progress">
				<div class="bar-wrap">
					<div class="bar" style="--width: {percent}%" />
				</div>
				<div class="percentage">
					<Countup value={percent} />%
				</div>
			</div>
		{/key}
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
	}
	.inner :global(h3) {
		margin-bottom: 1em;
	}
	.bar-wrap {
		position: relative;
		background: rgba(255, 255, 255, 0.1);
		flex: 1;
	}
	.bar {
		height: 80px;
		background: var(--primary-blue);
		background: linear-gradient(-86deg, rgba(73, 128, 223, 1) 0%, rgba(50, 94, 181, 1) 100%);
		animation: grow cubic-bezier(0.25, 0.46, 0.45, 0.94) 3.5s forwards;
	}
	.progress {
		position: relative;
		border-radius: 4px;
		overflow: hidden;
	}
	.percentage {
		min-width: 80px;
		text-align: center;
		position: absolute;
		right: 0.5em;
		font-size: 2em;
		top: 50%;
		transform: translateY(-50%);
	}
	@keyframes grow {
		0% {
			width: 0;
		}
		100% {
			width: var(--width);
		}
	}
</style>
