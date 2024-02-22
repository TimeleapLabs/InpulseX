<script>
	import Carousel from 'svelte-carousel';
	import { browser } from '$app/environment';
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import { linear } from 'svelte/easing';
	import { fade } from 'svelte/transition';
	import { onMount } from 'svelte';
	import { getImageFormatPath, getPhases } from '../../api';

	let phases = [];

	const showMore = [...phases].map((_) => false);

	const toggleShowMore = (index) => (event) => {
		event.preventDefault();
		showMore[index] = !showMore[index];
	};

	function spin(node, { duration = 400 }) {
		return {
			duration,
			css: (t) => {
				const eased = linear(t);
				return `
					transform: scale(${0.5 + eased / 2}) rotate(${eased * 360}deg);`;
			}
		};
	}

	function splitSteps(steps, side = 'left') {
		const half = Math.ceil(steps.length / 2);
		return side === 'left' ? steps.slice(0, half) : steps.slice(half);
	}

	onMount(async () => {
		const phasesData = await getPhases();
		phases = phasesData.map((phase, index) => ({
			...phase,
			index,
			stepsLeft: splitSteps(phase.steps, 'left'),
			stepsRight: splitSteps(phase.steps, 'right'),
			graphic: getImageFormatPath(phase.graphic, 'large')
		}));
	});

	let currentPageIndex = 2;

	const onPageChange = (event) => {
		currentPageIndex = event.detail;
	};
</script>

{#if browser}
	<div class="background" id="spacemap">
		<div class="phases">
			{#if phases.length}
				<Carousel dots={false} infinite={false} initialPageIndex={1} on:pageChange={onPageChange}>
					{#each phases as { title, from, to, stepsLeft, stepsRight, graphic, index } (title)}
						<div class="phase">
							{#if currentPageIndex === index}
								<div class="content" transition:fade>
									<div class="title">
										<Title>{@html title}</Title>
										<Title as="h3">{from} - {to}</Title>
									</div>
									<div class="milestones content-left">
										<ul>
											{#each stepsLeft as { title, done }}
												<Paragraph>
													<li transition:fade={{ delay: parseInt(index) * 100 }}>
														{title}{@html done
															? ' <span class="blue-highlight">&#x2714;</span>'
															: ''}
													</li>
												</Paragraph>
											{/each}
											{#if showMore[index]}
												{#each stepsRight as { title, done }}
													<Paragraph>
														<li transition:fade={{ delay: parseInt(index) * 100 }}>
															{title}{@html done
																? ' <span class="blue-highlight">&#x2714;</span>'
																: ''}
														</li>
													</Paragraph>
												{/each}
											{/if}
										</ul>
										{#if !showMore[index]}
											<a href="#show-more" class="show-more" on:click={toggleShowMore(index)}>
												Show more →
											</a>
										{:else}
											<a href="#show-more" class="show-more" on:click={toggleShowMore(index)}>
												Show less →
											</a>
										{/if}
									</div>
									<div class="milestones content-right">
										<ul>
											{#each stepsRight as { title, done }}
												<Paragraph>
													<li transition:fade={{ delay: parseInt(index) * 100 }}>
														{title}{@html done
															? ' <span class="blue-highlight">&#x2714;</span>'
															: ''}
													</li>
												</Paragraph>
											{/each}
										</ul>
									</div>
								</div>
								<div class="graphic" transition:spin>
									<img src={graphic} alt={title} />
								</div>
							{/if}
						</div>
					{/each}
				</Carousel>
			{/if}
		</div>
	</div>
{/if}

<style>
	.background {
		width: 100%;
		padding: 12em 6em;
		box-sizing: border-box;
		background: #140f29 url(/images/stars.png) no-repeat center center;
		background-size: contain;
	}

	.phases {
		height: 100%;
	}

	.phase {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		box-sizing: border-box;
	}

	.content {
		display: grid;
		grid-template-columns: 550px 1fr 1fr;
		justify-content: space-between;
		align-items: center;
		gap: 3em;
	}

	.milestones {
		display: flex;
		flex-direction: column;
		gap: 0.5em;
	}

	.milestones :global(p) {
		white-space: nowrap;
	}

	:global(.blue-highlight) {
		color: var(--primary-blue);
	}

	:global(.pink-highlight) {
		color: var(--primary-pink);
	}
	.graphic img {
		max-width: 100%;
	}
	.milestones :global(p) {
		max-width: 100%;
		word-wrap: normal;
		white-space: normal;
	}
	@media only screen and (max-width: 1440px) {
		.background {
			padding: 6em 4em;
		}
		.content {
			grid-template-columns: 1fr 1fr 1fr;
		}
	}
	@media only screen and (max-width: 1240px) {
		.background {
			padding: 3em 4em;
		}
		.content {
			grid-template-columns: 1fr 1fr;
		}
		.title {
			grid-column: span 2;
			padding: 1em;
		}
	}
	@media only screen and (min-width: 1200px) {
		.title {
			position: relative;
		}
		.title:after {
			content: '';
			background: #fff;
			position: absolute;
			width: 100px;
			height: 1em;
			right: 0;
			top: 50%;
		}
	}
	@media only screen and (min-width: 600px) {
		.show-more {
			display: none;
		}
	}
	@media only screen and (max-width: 600px) {
		.background {
			padding: 1em;
		}
		.content {
			grid-template-columns: 1fr;
			max-width: 100%;
			box-sizing: border-box;
			padding: 0;
		}
		.milestones :global(p) {
			font-size: 0.8em;
			max-width: 100%;
			word-wrap: normal;
			white-space: normal;
		}
		.content-right {
			display: none;
		}
		.title {
			font-size: 0.5em;
			grid-column: 1;
			text-align: center;
		}
		.show-more {
			text-decoration: none;
			display: inline-flex;
			align-items: center;
			gap: 0.5em;
			color: #fff;
			margin-top: 1em;
			padding-left: 2rem;
			animation: pulsate 0.11s ease-in-out infinite alternate;
		}
		.show-more:hover {
			text-decoration: underline;
		}
	}
	@keyframes pulsate {
		100% {
			/* Larger blur radius */
			text-shadow:
				0 0 4px #fff,
				0 0 11px #fff,
				0 0 19px #fff,
				0 0 40px #f09,
				0 0 80px #f09,
				0 0 90px #f09,
				0 0 100px #f09,
				0 0 150px #f09;
		}
		0% {
			/* A slightly smaller blur radius */
			text-shadow:
				0 0 4px #fff,
				0 0 10px #fff,
				0 0 18px #fff,
				0 0 38px #f09,
				0 0 73px #f09,
				0 0 80px #f09,
				0 0 94px #f09,
				0 0 140px #f09;
		}
	}
</style>
