<script>
	import Title from '../Title.svelte';
	import ERC1363Stake from '$lib/components/staking/ERC1363Stake.svelte';
</script>

<div class="staking">
	<div class="ripple blue" />
	<div class="ripple pink" />
	<div class="title">
		<Title as="h1">Staking</Title>
	</div>
	<div class="grid">
		<ERC1363Stake
			title="Stake IPX"
			start={new Date('2023-03-31T18:22:07.831Z')}
			address="0x5147B1A493A7891279b849C4bEC2F3f069cB9786"
			rewardSymbol="GC"
			rewardLogo="https://pools.outerringmmo.com/assets/images/gq.png"
			stakeLogo="https://pools.outerringmmo.com/assets/images/IPX.png"
		/>
		<ERC1363Stake
			title="Stake IPX Liquidity"
			start={new Date('2023-03-31T18:22:07.831Z')}
			address="0xb7D3C2825866D8523bE8B8aa4ad0eAbADc34B580"
			rewardSymbol="GC"
			rewardLogo="https://pools.outerringmmo.com/assets/images/gq.png"
			stakeLogo="https://pools.outerringmmo.com/assets/images/IPX.png"
		/>
	</div>
</div>

<style>
	.staking {
		display: flex;
		flex-direction: column;
		box-sizing: border-box;
		padding: 8em 12em 12em 12em;
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
		grid-template-columns: 1fr 1fr;
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
			padding: 1em 2em;
		}
		.grid {
			grid-template-columns: 1fr;
		}
	}
</style>
