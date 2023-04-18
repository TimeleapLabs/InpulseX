<script>
	import Carousel from '../Carousel.svelte';

	const items = [
		{ image: '/images/partners/thenftx.png' },
		//{ image: '/images/partners/wisdome.png' },
		{ image: '/images/partners/solidproof.png' },
		{ image: '/images/partners/thegamex.png' },
		{ image: '/images/partners/kenshi.png' },
		{ image: '/images/partners/cls.png' },
		//{ image: '/images/partners/theacademiax.png' },
		{ image: '/images/partners/gotbit.png' },
		{ image: '/images/partners/exverse.png' },
		{ image: '/images/partners/outerring.png' },
		{ image: '/images/partners/evocap.png' },
		{ image: '/images/partners/castrum.png' },
		{ image: '/images/partners/coinvestor.png' },
		{ image: '/images/partners/halvings.png' }
	];
</script>

<Carousel {items} particlesToShow={7} pauseOnFocus={true} autoplay={true} height={96} />
