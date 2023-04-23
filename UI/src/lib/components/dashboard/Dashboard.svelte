<script>
	import { onMount } from 'svelte';

	import Title from '../Title.svelte';
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

<div class="game">
	<div class="ripple blue" />
	<div class="video">
		<div class="player">
			<div class="title">
				<Title as="h1" centered>Staking Dashboard</Title>
			</div>
			<div class="wrap">
				<video bind:this={videoPlayer} src="/videos/welcome.mp4" controls={playing || undefined}>
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
</div>

<style>
	.wrap {
		position: relative;
	}
	.game {
		--video-width: 1024px;

		display: flex;
		flex-direction: column;
		box-sizing: border-box;
		padding: 8em 12em 12em 12em;
		background-color: #140f29;
		position: relative;
	}
	.title {
		margin-bottom: 4em;
	}
	.video {
		width: var(--video-width);
		max-width: 80%;
		margin: 0 auto;
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
		max-height: 830px;
		object-fit: cover;
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
		.video video {
			max-height: 380px;
		}
	}
	@media only screen and (max-width: 800px) {
		.video,
		video {
			max-width: 80%;
		}
		.video video {
			max-height: 320px;
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
		.video video {
			max-height: 280px;
		}
	}
</style>
