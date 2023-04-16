<script>
	import { Parallax, ParallaxLayer } from 'svelte-parallax';

	let parallax;
</script>

<div class="about">
	<Parallax
		sections={2}
		config={{ stiffness: 0.2, damping: 0.3 }}
		threshold={{ top: 0, bottom: 1 }}
		bind:this={parallax}
	>
		<ParallaxLayer rate={0.5} offset={0.4}>
			<h2>About InpulseX</h2>
			<h3>A token linked to the interplanetary journey</h3>
			<p>
				From the total suppply of $IPX tokens, 28% will be allocated to the greatest mission of
				humankind - The Mars Mission.
			</p>
			<p>
				ImpulseX shall offer financial support to SpaceX based on a progressive schedule triggered
				by the miilestones associated with its market cap.
			</p>
		</ParallaxLayer>
	</Parallax>
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
	}
	h2,
	h3 {
		font-family: 'Bebas';
		margin-top: 0;
	}
	h2 {
		font-size: 4em;
		margin-bottom: 1rem;
	}
	h3 {
		font-size: 2em;
	}
	p {
		font-family: 'Groningen';
		font-size: 18px;
		margin-top: 0;
		max-width: 30%;
		margin: 0 auto;
		margin-bottom: 1em;
	}
</style>
