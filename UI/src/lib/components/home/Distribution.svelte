<script>
	import Chart from 'chart.js/auto';
	import Title from '../Title.svelte';
	import Highlight from '../Highlight.svelte';

	let canvas;

	const colors = [
		'#3395ff', //15
		'#687de6', //4
		'#599dcc', //2
		'#7649b0', //23
		'#c961fc', //3
		'#ee58d5', //5
		'#3372b5', //10
		'#d85e5d', //8
		'#50cef7', //2
		'#ea7db4' //28
	];

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
						order: 1,
						backgroundColor: colors
					}
				]
			},
			options: {
				aspectRatio: window.outerWidth > 600 ? 1.33 : 1,
				hoverOffset: 50,
				layout: {
					padding: 40
				},
				plugins: {
					legend: {
						display: window.outerWidth > 600,
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
	.chart {
		position: relative;
		z-index: 1;
		width: 800px;
		height: 600px;
		z-index: 1;
		margin: 0 auto;
		max-width: 100%;
	}
	.distribution :global(.title) {
		position: relative;
		z-index: 1;
		margin-bottom: 1em;
	}
	@media only screen and (max-width: 600px) {
		.chart {
			height: 320px;
		}
	}
	@media only screen and (max-width: 960px) {
		.chart {
			height: 520px;
		}
	}
</style>
