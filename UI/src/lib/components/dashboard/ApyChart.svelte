<script>
	import Card from '../Card.svelte';
	import { DateTime, Duration } from 'luxon';
	import Chart from 'chart.js/auto';
	import Title from '../Title.svelte';

	export let userApy;
	export let start;
	export let unlockTime;

	const days = Math.round(
		DateTime.fromMillis(unlockTime).diff(DateTime.fromJSDate(start), 'days').days
	);

	const data = {
		labels: new Array(days)
			.fill(start)
			.map((date) => DateTime.fromJSDate(date))
			.map((date, i) => date.plus(Duration.fromObject({ days: i + 1 })))
			.map((date) => date.toFormat('LLL dd')),
		datasets: [
			{
				label: 'Total Rewards Earned',
				data: new Array(days).fill().map((_, i) => i * userApy),
				fill: true,
				backgroundColor: '#2b7bf3cc'
			}
		]
	};

	let canvas;

	const assembleChart = () => {
		const config = {
			type: 'bar',
			data: data,
			options: {
				responsive: true,
				aspectRatio: 3,
				elements: {
					point: {
						radius: 0
					}
				},
				plugins: {
					tooltip: {
						mode: 'index'
					},
					legend: {
						display: false
					}
				},
				interaction: {
					mode: 'nearest',
					axis: 'x',
					intersect: false
				},
				scales: {
					x: {
						title: {
							display: true,
							text: 'Days passed',
							color: '#fff'
						},
						ticks: {
							color: '#fff'
						},
						grid: {
							color: '#ffffff20'
						}
					},
					y: {
						stacked: true,
						title: {
							display: true,
							text: 'Rewards',
							color: '#fff'
						},
						ticks: {
							color: '#fff'
						},
						grid: {
							color: '#ffffff20'
						}
					}
				}
			}
		};
		new Chart(canvas, config);
	};

	$: if (canvas) {
		assembleChart();
	}
</script>

<Card>
	<div class="chart">
		<Title as="h3">Rewards chart</Title>
		<div class="chart-inner">
			<canvas bind:this={canvas} width="400" height="400" />
		</div>
	</div>
</Card>

<style>
	.chart {
		position: relative;
		z-index: 1;
		width: 100%;
		height: 100%;
		z-index: 1;
		margin: 0 auto;
		max-width: 100%;
		padding: 1em;
		box-sizing: border-box;
		display: flex;
		flex-direction: column;
	}
	.chart :global(h3) {
		margin-bottom: 1em;
	}
	.chart-inner {
		height: 100%;
		width: 100%;
		max-width: calc(100vw - 8em);
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>
