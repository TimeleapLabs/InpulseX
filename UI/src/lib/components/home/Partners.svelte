<script>
	import Carousel from '../Carousel.svelte';
	import Title from '../Title.svelte';

	const items = [
		{ image: '/images/partners/thenftx.png' },
		//{ image: '/images/partners/wisdome.png' },
		{ image: '/images/partners/solidproof.png' },
		{ image: '/images/partners/thegamex.png' },
		{ image: '/images/partners/kenshi.svg' },
		{ image: '/images/partners/cls.svg' },
		//{ image: '/images/partners/theacademiax.png' },
		{ image: '/images/partners/gotbit.png' },
		{ image: '/images/partners/exverse.png' },
		{ image: '/images/partners/outerring.png' },
		{ image: '/images/partners/evocap.png' },
		{ image: '/images/partners/castrum.png' },
		{ image: '/images/partners/coinvestor.png' },
		{ image: '/images/partners/halvings.png' }
	];

	let outerWidth;
	let particlesToShow = 5;

	$: if (outerWidth < 600) {
		particlesToShow = 1;
	} else if (outerWidth < 1200) {
		particlesToShow = 3;
	} else {
		particlesToShow = 5;
	}
</script>

<svelte:window bind:outerWidth />

<div class="partners">
	<div class="ripple blue" />
	<div class="ripple pink" />
	<Title as="h2" class="title">Strategic<br />Partnerships</Title>
	<Carousel {items} {particlesToShow} pauseOnFocus={true} autoplay={true} height={96} />
</div>

<style>
	.partners {
		position: relative;
		padding: 12em;
		background-color: #140f29;
		overflow: hidden;
	}
	.partners :global(.title) {
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
	@media only screen and (max-width: 600px) {
		.partners {
			padding: 1em 2em;
		}
	}
</style>
