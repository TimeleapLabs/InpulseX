<script>
	import Carousel from 'svelte-carousel';
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import { browser } from '$app/environment';

	const items = [
		{ video: '/videos/characters/commander.mp4' },
		{ video: '/videos/characters/eve.mp4' },
		{ video: '/videos/characters/fomotion.mp4' },
		{ video: '/videos/characters/jay.mp4' },
		{ video: '/videos/characters/jerry.mp4' },
		{ video: '/videos/characters/joe.mp4' },
		{ video: '/videos/characters/lisa.mp4' },
		{ video: '/videos/characters/rod.mp4' },
		{ video: '/videos/characters/rv-female.mp4' },
		{ video: '/videos/characters/rv-male.mp4' },
		{ video: '/videos/characters/suppoman.mp4' },
		{ video: '/videos/characters/xstronaut.mp4' }
	];

	let currentIndex = 0;

	const onPageChange = (event) => {
		currentIndex = event.detail;
	};

	const enumerate = (items) => items.map((item, index) => [item, index]);
</script>

<div class="characters">
	<div class="ripple blue" />
	<div class="ripple pink" />
	<Title as="h2" class="title" centered>Custom Characters</Title>
	{#if browser}
		<div class="carousel">
			<Carousel
				dots={false}
				pauseOnFocus={false}
				autoplay={true}
				particlesToShow={3}
				autoplayDuration={8000}
				on:pageChange={onPageChange}
			>
				{#each enumerate(items) as [item, index]}
					<div class="item">
						<div class="video">
							<div class="frame">
								{#if index === currentIndex + 1}
									<video
										class="active"
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
						{#if item.label}
							<span> {item.label} </span>
						{/if}
					</div>
				{/each}
			</Carousel>
		</div>
	{/if}
	<div class="paragraph">
		<Paragraph centered>
			<p>
				Custom characters provide players with an exceptional level of personalization and
				uniqueness, enabling them to leave an indelible mark on the game.
			</p>
			<p>Secure yours!!!</p>
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
		bottom: -280px;
		right: -400px;
		width: 800px;
		height: 800px;
		opacity: 0.6;
		max-width: 80%;
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
	.paragraph {
		padding: 4em 20em;
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
</style>
