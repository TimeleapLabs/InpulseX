<script>
	import { onMount } from 'svelte';
	import Paragraph from '../Paragraph.svelte';
	import Pause from '../graphics/Pause.svelte';
	import Play from '../graphics/Play.svelte';

	let videoPlayer;
	let overlay;
	let playing = false;
	let pauseHidden = false;
	let timeoutId;

	function play() {
		playing = true;
	}

	function pause() {
		playing = false;
	}

	const hidePause = () => {
		clearTimeout(timeoutId);
		timeoutId = setTimeout(() => {
			pauseHidden = true;
		}, 3000);
	};

	const handleMouseMove = () => {
		console.log('mouse move');
		if (playing) {
			pauseHidden = false;
			hidePause();
		}
	};

	$: {
		if (videoPlayer) {
			if (playing) {
				videoPlayer.play();
				hidePause();
			} else {
				videoPlayer.pause();
				clearTimeout(timeoutId);
			}
		}
	}

	$: if (overlay) {
		overlay.addEventListener('mousemove', handleMouseMove);
	}

	$: if (videoPlayer) {
		videoPlayer.addEventListener('ended', () => {
			playing = false;
		});
	}

	onMount(() => {
		return () => {
			overlay?.removeEventListener('mousemove', handleMouseMove);
		};
	});
</script>

<div class="game" id="game">
	<div class="ripple blue" />
	<div class="video">
		<div class="player">
			<div class="title">
				<img src="/images/starseed.png" alt="Starseed Awakening" class="game-logo" />
			</div>
			<div class="wrap">
				<video bind:this={videoPlayer} src="/videos/game-video.mp4">
					<track kind="captions" />
				</video>
				{#if playing}
					<button class="player-control" class:hidden={pauseHidden} on:click={pause}>
						<Pause width="128px" />
					</button>
				{:else}
					<button class="player-control" on:click={play}><Play width="128px" /></button>
				{/if}
			</div>
		</div>
	</div>
	<div class="description">
		<Paragraph centered>
			"Starseed Awakening" features an immersive narrative meticulously crafted from various
			sources, including "The Complete Earth Chronicles" by Zecharia Sitchin and much more. This
			mind-blowing adventure invites players to explore the true motivations behind Elon Musk's
			vision for colonising Mars.
			<br />
			Get ready to embark on the journey of a lifetime with "Starseed Awakening."
		</Paragraph>
	</div>
</div>

<style>
	.game {
		--video-width: 1024px;

		display: flex;
		flex-direction: column;
		box-sizing: border-box;
		padding: 24em 12em 12em 12em;
		background-color: #140f29;
		position: relative;
	}
	.title {
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.game-logo {
		max-width: 80%;
		width: 560px;
		margin-bottom: 2em;
		z-index: 2;
		position: relative;
	}

	.video {
		width: var(--video-width);
		max-width: 80%;
		margin: 0 auto;
	}
	.wrap {
		position: relative;
	}

	@media (max-width: 1280px) {
		.video {
			margin: 0 3em;
		}
	}

	.player {
		position: relative;
	}

	.video video {
		width: var(--video-width);
		max-width: 100%;
		background-color: black;
		box-shadow: 0 0px 40px 1px #dc15a444;
		border-radius: 3em;
	}

	.description {
		margin-top: 2em;
		z-index: 2;
		max-width: var(--video-width);
		align-self: center;
	}

	button.player-control {
		position: absolute;
		left: 0;
		top: 0;
		right: 0;
		bottom: 0;
		background-color: transparent;
		border: none;
		cursor: pointer;
		z-index: 1;
		width: var(--video-width);
		max-width: 100%;
		padding: 0;
	}

	button.player-control.hidden {
		display: none;
	}

	.player:hover button.player-control.hidden {
		display: block;
	}

	.ripple.blue {
		background: url(/images/ripple.blue.png) no-repeat center;
		background-size: contain;
		position: absolute;
		width: 1600px;
		height: 1600px;
		opacity: 0.6;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		z-index: 0;
		max-width: 80%;
	}

	@media only screen and (max-width: 1440px) {
		.game {
			padding: 8em 4em;
		}
	}
	@media only screen and (max-width: 960px) {
		.game {
			padding: 8em 2em;
		}
	}
	@media only screen and (max-width: 800px) {
		.video,
		video {
			max-width: 80%;
		}
	}
	@media only screen and (max-width: 600px) {
		.game {
			padding: 1em 2em;
		}
		.video {
			margin: 0;
			max-width: 100%;
		}
	}
</style>
