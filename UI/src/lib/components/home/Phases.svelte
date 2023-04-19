<script>
	import Carousel from 'svelte-carousel';
	import { browser } from '$app/environment';
	import ChevronLeft from '../../icons/chevron-left.svelte';
	import ChevronRight from '../../icons/chevron-right.svelte';
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';

	const phases = [
		{
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
			title: '<span class="blue-highlight">The second</span> phase',
			dateStart: '01.11.2022',
			dateEnd: '31.07.2023',
			topicsLeft: [
				'2nd Celebrity endorsement <span class="blue-highlight">&#x2714;</span>',
				'2nd Partnership: Outer Ring <span class="blue-highlight">&#x2714;</span>',
				'Expand Marketing Campaign <span class="blue-highlight">&#x2714;</span>',
				'TheNFTX launch <span class="blue-highlight">&#x2714;</span>',
				'Game Trailer release <span class="blue-highlight">&#x2714;</span>',
				'Xtronaut Membership Club'
			],
			topicsRight: [
				'ImpulseX Capital Group launch',
				'TheGameX launch',
				'1st NFT collection by Julius Horsthuis',
				'Implementation of 2nd network',
				'2nd Contract audit by CERTIK',
				'2nd CEX listing'
			],
			graphic: '/images/moon.png'
		},
		{
			title: 'The third <span class="pink-highlight">phase</span>',
			dateStart: '01.08.2023',
			dateEnd: '30.04.2024',
			topicsLeft: [
				'2nd NFT collection',
				'2nd NFT exposition London',
				'TheAcademiaX launch',
				'NFT Marketplace launch',
				'Starseed Game release'
			],
			topicsRight: [
				'Partnership with 3rd game token',
				'Merchandise store',
				'DEX launch (Name TBA)',
				'Expand Marketing Campaign'
			],
			graphic: '/images/mars.png'
		}
	];
</script>

{#if browser}
	<div class="background">
		<div class="phases">
			<Carousel
				dots={false}
				infinite={false}
				let:showPrevPage
				let:showNextPage
				let:currentPageIndex
				let:pagesCount
			>
				<button slot="prev" class="arrow" on:click={showPrevPage}>
					<ChevronLeft />
				</button>
				{#each phases as { title, dateStart, dateEnd, topicsLeft, topicsRight, graphic } (title)}
					<div class="phase">
						<div class="content">
							<div class="title">
								<Title>{@html title}</Title>
								<Title as="h3">{dateStart} - {dateEnd}</Title>
							</div>
							<div class="milestones content-left">
								{#each topicsLeft as topic (topic)}
									<Paragraph>{@html topic}</Paragraph>
								{/each}
							</div>
							<div class="milestones content-right">
								{#each topicsRight as topic (topic)}
									<Paragraph>{@html topic}</Paragraph>
								{/each}
							</div>
						</div>
						<div class="graphic">
							<img src={graphic} alt={title} />
						</div>
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
		background-color: #140f29;
		padding: 12em 6em;
		box-sizing: border-box;
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
		gap: 1em;
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
</style>
