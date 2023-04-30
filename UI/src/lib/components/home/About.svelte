<script>
	import { Parallax, ParallaxLayer } from 'svelte-parallax';

	let parallax;
</script>

<div class="about" id="about">
	<div class="fade" />
	<Parallax
		sections={2}
		config={{ stiffness: 0.2, damping: 0.3 }}
		threshold={{ top: 0, bottom: 1 }}
		bind:this={parallax}
	>
		<ParallaxLayer rate={0.5} offset={0.4}>
			<h2>About</h2>
			<h3>A token linked to the interplanetary journey</h3>
			<p>
				InpulseX is a visionary initiative designed to support humanity's greatest goal: the Mars
				mission. The project is committed to raising awareness and gathering financial resources to
				contribute to the mission's progress.
			</p>
			<p>
				InpulseX aims to become the leading blockchain powerhouse, offering unwavering support to
				SpaceX and the entire space exploration industry throughout this extraordinary journey.
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
	@media only screen and (max-width: 600px) {
		p {
			max-width: 80%;
		}
	}
</style>
