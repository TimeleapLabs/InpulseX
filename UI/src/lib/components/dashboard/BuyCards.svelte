<script>
	import Title from '../Title.svelte';
	import Card from './Card.svelte';
</script>

<div class="swap">
	<div class="ripple blue" />
	<div class="title">
		<Title as="h1" anchor="how-to-buy">How to Buy</Title>
	</div>
	<div class="swap-wrap">
		<Card
			title="On BNB Chain"
			body="IPX token address on the BNB chain is 0xCDB96d3aEf363a036c6CF6c9b5736d79f0E404e2. You can buy our token on PancakeSwap."
			href="https://pancakeswap.finance/swap?outputCurrency=0xCDB96d3aEf363a036c6CF6c9b5736d79f0E404e2"
		/>
		<Card
			title="On Ethereum"
			body="IPX token address on the Ethereum is 0xc5Be5F4B9aeEC885D8c9E506901477A950663BC3. You can buy our token on UniSwap."
			href="https://app.uniswap.org/swap?chain=mainnet&outputCurrency=0xc5Be5F4B9aeEC885D8c9E506901477A950663BC3"
		/>
	</div>
</div>

<style>
	.swap {
		display: flex;
		flex-direction: column;
		box-sizing: border-box;
		padding: 0em 12em 8em 12em;
		position: relative;
	}
	.swap > * {
		z-index: 1;
		position: relative;
	}
	.title {
		margin-bottom: 4em;
	}
	.ripple.blue {
		background: url(/images/ripple.blue.png) no-repeat center;
		background-size: contain;
		position: absolute;
		width: 1600px;
		height: 1600px;
		opacity: 0.1;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		z-index: 0;
		max-width: 80%;
		z-index: 0;
		max-height: 100%;
	}
	.swap-wrap {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		gap: 4em;
	}
	@media only screen and (max-width: 1440px) {
		.swap {
			padding: 8em 4em;
		}
	}
	@media only screen and (max-width: 960px) {
		.swap {
			padding: 8em 2em;
		}
		.swap-wrap {
			grid-template-columns: 1fr 1fr;
		}
	}

	@media only screen and (max-width: 600px) {
		.swap {
			padding: 1em 2em;
			padding-bottom: 4em;
		}
		.swap-wrap {
			grid-template-columns: 1fr;
		}
	}
</style>
