<script>
	import Carousel from 'svelte-carousel';
	import { browser } from '$app/environment';
	import ChevronLeft from '../../icons/chevron-left.svelte';
	import ChevronRight from '../../icons/chevron-right.svelte';
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import { linear } from 'svelte/easing';
	import { fade } from 'svelte/transition';

	const phases = [
		{
			index: 0,
			title: 'The first <span class="blue-highlight">phase</span>',
			dateStart: '02.02.2022',
			dateEnd: '31.10.2022',
			topicsLeft: [
				'Pancakeswap listing <span class="blue-highlight">&#x2714;</span>',
				'1st Meme contest <span class="blue-highlight">&#x2714;</span>',
				'Digifinex listing <span class="blue-highlight">&#x2714;</span>',
				'1st $IPX token airdrop <span class="blue-highlight">&#x2714;</span>'
			],
			topicsRight: [
				'1st NFT exposition Los Angeles <span class="blue-highlight">&#x2714;</span>',
				'1st Celebrity endorsement <span class="blue-highlight">&#x2714;</span>',
				'1st Partnership: Akkadia One <span class="blue-highlight">&#x2714;</span>',
				'Marketing Campaign <span class="blue-highlight">&#x2714;</span>'
			],
			graphic: '/images/earth.png'
		},
		{
			index: 1,
			title: '<span class="blue-highlight">The second</span> phase',
			dateStart: '01.11.2022',
			dateEnd: '31.07.2023',
			topicsLeft: [
				'2nd Celebrity endorsement <span class="blue-highlight">&#x2714;</span>',
				'2nd Partnership: Outer Ring <span class="blue-highlight">&#x2714;</span>',
				'Expand Marketing Campaign <span class="blue-highlight">&#x2714;</span>',
				'TheNFTX launch <span class="blue-highlight">&#x2714;</span>',
				'Game Trailer release <span class="blue-highlight">&#x2714;</span>',
				'1st AI Art Contest <span class="blue-highlight">&#x2714;</span>',
				' 2nd Starseed Chapter One Trailer',
				'1st NFT Collection By Julius Horsthuis'
			],
			topicsRight: [
				'2nd CEX Listing',
				'2nd Network Launch: Ethereum',
				'2nd DEX Listing: Uniswap',
				'Staking Dashboard Launch',
				'Xstronaut Membership Club Launch',
				'InpulseX Capital Group Launch',
				'TheGameX Pillar Launch',
				'Expand marketing Campaign'
			],
			graphic: '/images/earth.png'
		},
		{
			index: 2,
			title: 'The third <span class="pink-highlight">phase</span>',
			dateStart: '01.08.2023',
			dateEnd: '30.04.2024',
			topicsLeft: [
				'TheAcademiaX Pillar Launch',
				'2nd NFT Exposition: London',
				'Starseed Chapter One: Awakening Full Trailer',
				'3rd CEX Listing',
				'4th CEX Listing',
				'3rd Network Launch',
				'3rd DEX Listing',
				'4th Network Launch',
				'4th DEX Listing',
				'3rd Partnership Game Token'
			],
			topicsRight: [
				'Starseed Chapter One: Awakening Game Demo',
				'Expand Marketing Campaign',
				'InpulseX Ecosystem Merchandise Store Launch',
				'1st InpulseX Video Contest',
				'AI Powered: Mission Control Launch',
				'Expand Worldwide Marketing Campaign',
				'2nd NFT Collection Launch',
				'TheNFTX Marketplace Launch',
				'TheAcademiaX Educational Workshops',
				'Starseed Chapter One: Awakening Game Launch'
			],
			graphic: '/images/moon.png'
		},
		{
			index: 3,
			title: 'The fourth <span class="pink-highlight">phase</span>',
			dateStart: '01.05.2024',
			dateEnd: '31.01.2025',
			topicsLeft: [
				'5th CEX Listing',
				'6th CEX Listing',
				'5th Network Launch',
				'5th DEX Listing',
				'4th Partnership Game Token',
				'Starseed: Voyage Trailer Teaser',
				'6th Network Launch',
				'6th DEX Listing'
			],
			topicsRight: [
				'2nd AI Art Contest',
				'2nd NFT Collection Launch',
				'3rd NFT Exposition: Dubai',
				'InpulseX 1st Limited-Edition Clothing',
				'InpulseX Crypto Payment Card',
				'1st Brand Sponsored By InpulseX',
				'Starseed: Voyage Demo Launch',
				'Expand Worldwide Marketing Campaign'
			],
			graphic: '/images/mars.png'
		}
	];

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
</script>

{#if browser}
	<div class="background" id="spacemap">
		<div class="phases">
			<Carousel
				dots={false}
				infinite={false}
				initialPageIndex={1}
				let:showPrevPage
				let:showNextPage
				let:currentPageIndex
				let:pagesCount
			>
				<button slot="prev" class="arrow" on:click={showPrevPage}>
					<ChevronLeft />
				</button>
				{#each phases as { title, dateStart, dateEnd, topicsLeft, topicsRight, graphic, index } (title)}
					<div class="phase">
						{#if !currentPageIndex || currentPageIndex === index}
							<div class="content" transition:fade>
								<div class="title">
									<Title>{@html title}</Title>
									<Title as="h3">{dateStart} - {dateEnd}</Title>
								</div>
								<div class="milestones content-left">
									<ul>
										{#each Object.entries(topicsLeft) as [index, topic]}
											<Paragraph>
												<li transition:fade={{ delay: parseInt(index) * 100 }}>{@html topic}</li>
											</Paragraph>
										{/each}
									</ul>
								</div>
								<div class="milestones content-right">
									<ul>
										{#each Object.entries(topicsRight) as [index, topic]}
											<Paragraph>
												<li transition:fade={{ delay: parseInt(index) * 100 }}>{@html topic}</li>
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
				<button slot="next" class="arrow" on:click={showNextPage}>
					<ChevronRight />
				</button>
			</Carousel>
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

	.arrow {
		display: flex;
		align-items: center;
		justify-content: center;
		margin-top: 7.5em;
		border: none;
		outline: none;
		width: 3em;
		height: 3em;
		padding: 1em;
		border-radius: 50%;
		background-color: white;
		color: var(--primary-blue);
		cursor: pointer;
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
	@media only screen and (max-width: 600px) {
		.background {
			padding: 1em;
		}
		.content {
			grid-template-columns: 1fr;
			max-width: 100%;
			box-sizing: border-box;
			padding: 1em;
		}
		.milestones :global(p) {
			font-size: 0.8em;
			max-width: 100%;
			word-wrap: normal;
			white-space: normal;
		}
		.content-right {
			margin-top: -5em;
		}
		.title {
			font-size: 0.5em;
			grid-column: 1;
			text-align: center;
		}
	}
</style>
