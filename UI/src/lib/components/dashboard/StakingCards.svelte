<script>
	import Title from '../Title.svelte';
	import Card from './Card.svelte';

	import { getStakings } from '../../api';
	import { onMount } from 'svelte';

	let stakings = [];

	onMount(async () => {
		stakings = await getStakings();
	});
</script>

<div class="staking">
	<div class="ripple blue" />
	<div class="ripple pink" />
	<div class="title">
		<Title as="h1">Staking</Title>
	</div>
	<div class="grid">
		{#each stakings as staking}
			<Card
				title={staking.title}
				body={staking.description}
				href={`/dashboard/staking/${staking.id}`}
			/>
		{/each}
	</div>
</div>

<style>
	.staking {
		display: flex;
		flex-direction: column;
		box-sizing: border-box;
		padding: 8em 12em 8em 12em;
		position: relative;
	}
	.staking > * {
		z-index: 1;
		position: relative;
	}
	.title {
		margin-bottom: 4em;
	}
	.ripple.blue {
		background: url(/images/ripple.blue.half.png) no-repeat center;
		background-size: contain;
		position: absolute;
		width: 100%;
		height: 100%;
		opacity: 0.1;
		top: 0;
		left: 0;
		z-index: 0;
		max-width: 80%;
		z-index: 0;
		max-height: 100%;
		background-position: left top;
	}
	.ripple.pink {
		background: url(/images/ripple.pink.half.png) no-repeat center;
		background-size: contain;
		position: absolute;
		width: 100%;
		height: 100%;
		opacity: 0.1;
		bottom: 0;
		right: 0;
		z-index: 0;
		max-width: 80%;
		z-index: 0;
		max-height: 100%;
		background-position: right bottom;
	}
	.grid {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		gap: 4em;
	}
	@media only screen and (max-width: 1440px) {
		.staking {
			padding: 8em 4em;
		}
	}
	@media only screen and (max-width: 960px) {
		.staking {
			padding: 8em 2em;
		}
	}

	@media only screen and (max-width: 600px) {
		.staking {
			padding: 6em 2em;
		}
		.grid {
			grid-template-columns: 1fr;
		}
	}
</style>
