<script>
	import Chart from 'chart.js/auto';
	import { onMount } from 'svelte';
	import Title from '../Title.svelte';
	import Highlight from '../Highlight.svelte';

	let canvas;

	const assembleChart = () => {
		const data = [
			{ whom: 'Team', count: 15 },
			{ whom: 'Strategic Partners', count: 6 },
			{ whom: 'Staking Rewards', count: 10 },
			{ whom: 'SpaceX', count: 25 },
			{ whom: 'Airdrop', count: 1 },
			{ whom: 'Game Development', count: 5 },
			{ whom: 'Liquidity', count: 3 },
			{ whom: 'Marketing', count: 10 },
			{ whom: 'Net Development', count: 3 },
			{ whom: 'Public Sale', count: 18 },
			{ whom: 'Reserves', count: 2 },
			{ whom: 'Seed Sale', count: 3 }
		];

		new Chart(canvas, {
			type: 'pie',
			data: {
				labels: data.map((row) => row.whom),
				datasets: [
					{
						label: 'Token distribution',
						data: data.map((row) => row.count),
						order: 1
					}
				]
			},
			options: {
				aspectRatio: 1.33,
				hoverOffset: 50,
				layout: {
					padding: 40
				},
				plugins: {
					legend: {
						display: true,
						align: 'center',
						position: 'left'
					},
					tooltip: {
						callbacks: {
							label: function (context) {
								const label = context.label,
									percentage = context.raw;

								return `${label}: ${percentage}%`;
							}
						}
					}
				}
			}
		});
	};

	$: if (canvas) {
		assembleChart();
	}
</script>

<div class="distribution">
	<div class="background" />
	<Title class="title" centered><Highlight>Token</Highlight> distribution</Title>
	<div class="chart">
		<canvas bind:this={canvas} width="800" height="800" />
	</div>
</div>

<style>
	.distribution {
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
	.chart {
		position: relative;
		z-index: 1;
		width: 800px;
		height: 600px;
		z-index: 1;
		margin: 0 auto;
	}
	.distribution :global(.title) {
		position: relative;
		z-index: 1;
		margin-bottom: 1em;
	}
</style>
