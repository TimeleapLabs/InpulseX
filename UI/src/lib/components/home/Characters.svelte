<script>
	import Carousel from 'svelte-carousel';
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import { browser } from '$app/environment';

	const itemsFix = [
		{},
		{ video: '/videos/characters/commander.mp4' },
		{ video: '/videos/characters/jay.mp4' },
		{ video: '/videos/characters/eve.mp4' },
		{ video: '/videos/characters/rod.mp4' },
		{ video: '/videos/characters/rv-female.mp4' },
		{ video: '/videos/characters/xstronaut.mp4' },
		{ video: '/videos/characters/rv-male.mp4' },
		{ video: '/videos/characters/lisa.mp4' },
		{ video: '/videos/characters/suppoman.mp4' },
		{ video: '/videos/characters/jerry.mp4' },
		{ video: '/videos/characters/joe.mp4' },
		{ video: '/videos/characters/fomotion.mp4' },
		{}
	];

	let currentIndex = 0;

	const onPageChange = (event) => {
		currentIndex = event.detail;
	};

	const enumerate = (items) => items.map((item, index) => [item, index]);

	let outerWidth;
	let particlesToShow = 3;

	$: if (outerWidth < 600) {
		particlesToShow = 1;
	} else if (outerWidth < 1200) {
		particlesToShow = 2;
	} else {
		particlesToShow = 3;
	}

	const isCurrentItem = (index, currentIndex) => {
		return index === currentIndex + 1;
	};

	let items = itemsFix;

	$: if (outerWidth < 600) {
		items = itemsFix.slice(1, -1);
	}
</script>

<svelte:window bind:outerWidth />

<div class="characters" id="characters">
	<div class="ripple blue" />
	<div class="ripple pink" />
	<Title as="h2" class="title" centered>NFT Custom Characters</Title>
	{#if browser}
		<div class="carousel">
			<Carousel
				dots={false}
				pauseOnFocus={false}
				autoplay={true}
				{particlesToShow}
				autoplayDuration={8000}
				on:pageChange={onPageChange}
				infinite={false}
			>
				{#each enumerate(items) as [item, index]}
					{#if item.video}
						<div class="item">
							<div class="video">
								<div class="frame">
									{#if particlesToShow === 1 || isCurrentItem(index, currentIndex)}
										<video
											class="active"
											data-index={index}
											data-condition={isCurrentItem(index, currentIndex)}
											data-current={currentIndex}
											class:alone={particlesToShow === 1}
											src={item.video}
											alt={item.label || 'Carousel'}
											autoplay
											muted
										/>
									{:else}
										<video src={item.video} alt={item.label || 'Carousel'} muted />
									{/if}
								</div>
							</div>
						</div>
					{:else}
						<span />
					{/if}
				{/each}
			</Carousel>
		</div>
	{/if}
	<div class="paragraph">
		<Paragraph centered>
			<p>
				Custom characters in the Starseed game offer players an unparalleled level of
				personalization, allowing them to create a character that reflects their individuality and
				unique style.
			</p>
			<p>
				This leads to a more immersive and engaging experience, making the Starseed game more than
				just a game but a personal adventure.
			</p>
			<a href="https://bit.ly/TheNFTX_Registration" class="start" target="_blank" rel="noreferrer">
				<Title as="h4">Secure yours now!</Title>
			</a>
		</Paragraph>
	</div>
</div>

<style>
	.characters {
		position: relative;
		padding: 12em;
		background-color: #140f29;
		overflow: hidden;
	}
	.characters :global(.title) {
		position: relative;
		z-index: 1;
		margin-bottom: 1em;
	}
	.ripple.blue {
		background: url(/images/ripple.blue.png) no-repeat center;
		background-size: contain;
		position: absolute;
		top: -80px;
		left: -400px;
		width: 800px;
		height: 800px;
		opacity: 0.6;
		max-width: 80%;
	}
	.ripple.pink {
		background: url(/images/ripple.pink.png) no-repeat center;
		background-size: contain;
		position: absolute;
		bottom: -80px;
		right: -400px;
		width: 800px;
		height: 800px;
		opacity: 0.6;
		max-width: 80%;
	}
	a.start {
		border-radius: 1em;
		background-color: #dc15a4;
		border: none;
		padding: 1em;
		color: white;
		cursor: pointer;
		margin: 2em auto;
		z-index: 2;
		text-decoration: none;
		display: flex;
		width: 260px;
		align-items: center;
		justify-content: center;
	}
	.start :global(h4) {
		font-size: 2em;
	}
	.video {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 360px;
	}
	video {
		height: 240px;
		width: 240px;
		object-fit: cover;
		border-radius: 0.5em;
		opacity: 0.4;
	}
	video.active {
		opacity: 1;
		transform: scale(1.5);
	}
	video.active.alone {
		transform: scale(1);
	}
	.paragraph {
		padding: 4em 18em;
		text-align: center;
	}
	@media only screen and (max-width: 600px) {
		.characters {
			padding: 1em 2em;
		}
		.paragraph {
			padding: 1em;
		}
	}
	@media only screen and (max-width: 1440px) {
		.characters {
			padding: 4em;
		}
		.paragraph {
			padding: 2em 8em;
		}
	}
	@media only screen and (max-width: 960px) {
		.characters {
			padding: 2em;
		}
		.paragraph {
			padding: 1em 2em;
		}
	}
	@media only screen and (max-width: 600px) {
		.start :global(h4) {
			font-size: 1.5em;
		}
	}
</style>
