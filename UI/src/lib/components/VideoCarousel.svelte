<script>
	import Carousel from 'svelte-carousel';
	import { browser } from '$app/environment';

	export let height = 256;
	export let width = 256;
	export let items = [];
</script>

{#if browser}
	<div style="--height: {height}px; --width: {width}px" class="carousel">
		<Carousel dots={false} pauseOnFocus={true} autoplay={true} {...$$restProps}>
			{#each items as item}
				<div class="item">
					<div class="image">
						<video src={item.video} alt={item.label || 'Carousel'} autoplay loop muted />
					</div>
					{#if item.label}
						<span> {item.label} </span>
					{/if}
				</div>
			{/each}
		</Carousel>
	</div>
{/if}

<style>
	.item {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 1em;
		transform: scale(0.8);
	}
	.image {
		height: var(--height);
		width: var(--width);
		overflow: hidden;
	}
	.image img {
		width: 100%;
		height: 100%;
		object-fit: contain;
	}
</style>
