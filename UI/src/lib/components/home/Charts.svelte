<script>
	import DistributionSchedule from './DistributionSchedule.svelte';
	import Distribution from './Distribution.svelte';
	import Button from '../Button.svelte';

	let chart = 0;
</script>

<div class="charts" id="tokenomics">
	<div class="background" />

	{#if chart === 0}
		<Distribution />
	{:else}
		<DistributionSchedule />
	{/if}

	<div class="center">
		<div class="buttons">
			<Button on:click={() => (chart = 0)}>Token Distribution</Button>
			<Button on:click={() => (chart = 1)}>Distribution Schedule</Button>
		</div>
	</div>
</div>

<style>
	.charts {
		position: relative;
		padding: 12em;
		background-color: #140f29;
	}
	.background {
		background: url(/images/grid.pink.png) no-repeat center center;
		background-size: contain;
		width: 60%;
		height: 60%;
		position: absolute;
		top: 0;
		left: 50%;
		transform: translate(-50%, 0);
		z-index: 0;
		opacity: 0.4;
	}
	.center {
		display: flex;
		justify-content: center;
		margin-top: 2em;
	}
	.buttons {
		display: flex;
		gap: 2em;
		border-radius: 1em;
	}
	@media only screen and (max-width: 600px) {
		.charts {
			padding: 1em 2em;
		}
	}
	@media only screen and (max-width: 1440px) {
		.charts {
			padding: 6em;
		}
	}
	@media only screen and (max-width: 960px) {
		.charts {
			padding: 3em;
		}
	}
</style>
