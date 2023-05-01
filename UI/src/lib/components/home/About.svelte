<script>
	import { onMount } from 'svelte';

	import { Parallax, ParallaxLayer } from 'svelte-parallax';
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import { getAboutSection } from '../../api';

	let aboutData = null;

	onMount(async () => {
		aboutData = await getAboutSection();
	});
</script>

<div class="about" id="about">
	{#if aboutData}
		<div class="fade" />
		<Parallax
			sections={2}
			config={{ stiffness: 0.2, damping: 0.3 }}
			threshold={{ top: 0, bottom: 1 }}
		>
			<ParallaxLayer rate={0.5} offset={0.4}>
				<div class="inner">
					<Title as="h2">{aboutData.title}</Title>
					<Title as="h3">{aboutData.subtitle}</Title>
					<Paragraph>
						{@html aboutData.description}
					</Paragraph>
				</div>
			</ParallaxLayer>
		</Parallax>
	{/if}
</div>

<style>
	.about {
		width: 100vw;
		height: 100vh;
		background-image: url('/images/about.png');
		background-position: center center;
		background-repeat: no-repeat;
		background-size: cover;
		align-items: center;
		justify-content: center;
		flex-direction: column;
		text-align: center;
		box-shadow: 0px -4px 32px 20px rgba(0, 0, 0, 1);
		position: relative;
	}
	.fade {
		background: linear-gradient(
			180deg,
			rgba(0, 0, 0, 0.9402354691876751) 10%,
			rgba(0, 0, 0, 0.6181066176470589) 40%,
			rgba(0, 0, 0, 0) 100%
		);
		height: 10vh;
		position: absolute;
		z-index: 1;
		top: 0;
		left: 0;
		width: 100vw;
	}
	.inner {
		display: flex;
		flex-direction: column;
		gap: 2em;
		max-width: 40%;
		margin: 0 auto;
	}
</style>
