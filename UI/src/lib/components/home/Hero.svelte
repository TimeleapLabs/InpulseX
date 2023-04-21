<script>
	import Button from '../Button.svelte';
	import ArrowDown from '../icons/ArrowDown.svelte';
	import Title from '../Title.svelte';
	import X from '../icons/X.svelte';
	import { fade } from 'svelte/transition';

	let message = true;

	const close = () => (message = false);
</script>

<div class="hero">
	<div class="content">
		{#if message}
			<div class="message" transition:fade>
				<div>
					InpulseX has recently migrated from Old Contract to New Contract. For more information,
					please check the new InpulseX profile on
					<a
						rel="noreferrer"
						target="_blank"
						href="https://coinmarketcap.com/currencies/inpulsex-new/"
					>
						Coinmarketcap.
					</a>
				</div>
				<a href="#close" class="close" on:click={close}>
					<X width="1em" height="1em" />
				</a>
			</div>
		{/if}

		<Title class="title">The journey to become a multiplanetary species</Title>
		<Button
			href="https://pancakeswap.finance/swap?outputCurrency=0xCDB96d3aEf363a036c6CF6c9b5736d79f0E404e2"
			target="_blank"
		>
			Join now
		</Button>
	</div>
	<div class="background">
		<video autoplay muted poster="/images/hero.png">
			<source src="/videos/hero.mp4" type="video/mp4" />
			<source src="/videos/hero.webm" type="video/webm" />
			<img src="/images/hero.png" alt="Your browser does not support the video tag" />
		</video>
	</div>
	<div class="arrow">
		<a href="#about">
			<ArrowDown width="36px" height="36px" />
		</a>
	</div>
</div>

<style>
	.hero {
		position: relative;
		height: 100vh;
		width: 100vw;
		display: flex;
		justify-content: center;
		flex-direction: column;
	}
	.background {
		position: absolute;
		height: 100vh;
		width: 100vw;
		left: 0;
		top: 0;
	}
	.content {
		z-index: 1;
		position: relative;
		padding: 4em;
		display: flex;
		justify-content: center;
		align-items: flex-start;
		height: calc(100% - 96px);
		box-sizing: border-box;
		flex-direction: column;
		gap: 2em;
		flex: 1;
	}
	video,
	img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	.hero :global(.title) {
		font-size: 5em;
		margin: 0;
		width: 460px;
		max-width: 80%;
		opacity: 0.9;
	}
	.arrow {
		text-align: center;
		margin-bottom: 1em;
	}
	a {
		height: 32px;
		display: inline;
		text-align: center;
		position: relative;
		z-index: 1;
		opacity: 0.7;
		transition: 0.4s all cubic-bezier(0.47, 0, 0.745, 0.715);
	}
	a:hover {
		opacity: 1;
	}
	@media only screen and (max-width: 1080px) {
		.hero :global(.title) {
			font-size: 4em;
		}
	}
	@media only screen and (max-width: 600px) {
		.hero :global(.title) {
			font-size: 3em;
		}
	}
	.message {
		background: #ffefbd;
		color: #000;
		padding: 1em;
		display: flex;
		align-items: center;
		border-radius: 1em;
		gap: 1em;
	}
	a {
		text-decoration: none;
	}
	a.close {
		color: #000;
		display: flex;
		align-items: center;
	}
	@media only screen and (max-width: 600px) {
		a.close {
			align-self: flex-start;
		}
	}
	@media only screen and (min-width: 600px) and (max-height: 960px) {
		.hero :global(.title) {
			font-size: 4em;
		}
	}
	@media only screen and (min-width: 600px) and (max-height: 690px) {
		.hero :global(.title) {
			font-size: 2em;
		}
	}
</style>
