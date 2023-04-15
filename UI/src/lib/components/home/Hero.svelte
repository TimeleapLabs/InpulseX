<script>
	import Button from '../Button.svelte';
</script>

<div class="hero">
	<div class="content">
		<h1>The journey to become a multiplanetary species</h1>
		<Button href="#content">Let's go!</Button>
	</div>
	<div class="background">
		<video autoplay muted poster="/images/hero.png">
			<source src="/videos/hero.mp4" type="video/mp4" />
			<source src="/videos/hero.webm" type="video/webm" />
			<img src="/images/hero.png" alt="Your browser does not support the video tag" />
		</video>
	</div>
</div>

<style>
	.hero {
		position: relative;
		height: 100vh;
		width: 100vw;
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
		height: 100%;
		flex-direction: column;
		gap: 2em;
	}
	video,
	img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	h1 {
		font-size: 6em;
		color: var(--primary-blue);
		font-family: 'Bebas';
		margin: 0;
		max-width: 760px;
		opacity: 0.9;
		background-image: linear-gradient(87deg, var(--primary-blue), var(--seondary-blue));
		background-clip: text;
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		-moz-background-clip: text;
		-moz-text-fill-color: transparent;
	}
</style>
