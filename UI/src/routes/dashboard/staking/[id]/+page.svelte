<script>
	import Title from '$lib/components/Title.svelte';
	import ERC1363Stake from '$lib/components/staking/ERC1363Stake.svelte';
	import ERC721Stake from '$lib/components/staking/ERC721Stake.svelte';
	import ApyChart from '$lib/components/dashboard/ApyChart.svelte';
	import RewardCounter from '$lib/components/dashboard/RewardCounter.svelte';
	import Progress from '$lib/components/dashboard/Progress.svelte';

	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import { getStakingById, getImageFormatPath } from '$lib/api';

	let staking;

	let userApy = 0;
	let unlockTime = null;

	onMount(async () => {
		const data = await getStakingById($page.params.id);
		staking = {
			...data,
			stakingIcon: getImageFormatPath(data.stakingIcon, 'thumbnail'),
			rewardIcon: getImageFormatPath(data.rewardIcon, 'thumbnail'),
			start: new Date(data.start)
		};
	});
</script>

<div class="staking">
	<div class="ripple blue" />
	<div class="ripple pink" />
	<div class="title">
		<Title as="h1">Staking</Title>
	</div>
	<div class="grid">
		{#if staking?.stakeTokenType === 'ERC721'}
			<ERC721Stake
				title={staking.title}
				addresses={staking.contracts.map(({ contract }) => contract)}
				stakeSymbol={staking.stakeTokenSymbol}
				rewardSymbol={staking.rewardTokenSymbol}
				rewardLogo={staking.rewardIcon}
				stakeLogo={staking.stakingIcon}
				start={staking.start}
				chain={staking.blockchain.toLowerCase()}
				bind:unlockTime
				bind:userApy
			/>
		{:else if staking?.stakeTokenType === 'ERC1363'}
			<ERC1363Stake
				title={staking.title}
				addresses={staking.contracts.map(({ contract }) => contract)}
				stakeSymbol={staking.stakeTokenSymbol}
				rewardSymbol={staking.rewardTokenSymbol}
				rewardLogo={staking.rewardIcon}
				stakeLogo={staking.stakingIcon}
				start={staking.start}
				chain={staking.blockchain.toLowerCase()}
				rewards={staking.rewards || ['22950000', '30300000']}
				bind:unlockTime
				bind:userApy
			/>
		{:else}
			Loading
		{/if}
		{#if userApy && unlockTime}
			<ApyChart start={staking.start} {unlockTime} {userApy} />
			<RewardCounter {userApy} start={staking.start} units={staking.rewardTokenSymbol} />
		{/if}
		{#if unlockTime}
			<Progress start={staking.start} {unlockTime} />
		{/if}
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
		.grid {
			grid-template-columns: 1fr;
		}
	}

	@media only screen and (max-width: 600px) {
		.staking {
			padding: 6em 2em;
		}
	}
</style>
