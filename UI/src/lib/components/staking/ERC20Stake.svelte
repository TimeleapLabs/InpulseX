<script>
	import Card from '../Card.svelte';
	import Button from '../Button.svelte';
	import NumberInput from '../NumberInput.svelte';
	import Table from '../Table.svelte';

	import { wallet } from '../../../stores/wallet';
	import { ethers } from 'ethers';
	import { onMount } from 'svelte';

	import toast from 'svelte-french-toast';

	import abi from '../../abi/staking/contracts/staking/ERC20.sol/ERC20StakerERC20Rewarder.json';
	import tokenAbi from '@openzeppelin/contracts/build/contracts/IERC20.json';

	import Calculator from '../../icons/calculator.svelte';
	import Coins from '../../icons/coins.svelte';

	export let title;
	export let address;
	export let stakeSymbol = 'IPX';
	export let stakeLogo = '';
	export let rewardSymbol = 'BUSD';
	export let rewardLogo = '';
	export let start;

	let contract, token, rewardToken, provider, user, signer;
	let amount = 0;
	let unlockTime;
	let busy = false;
	let showStake = true;

	let data = [
		{ title: 'Your stake', value: `0 ${stakeSymbol}`, icon: stakeLogo },
		{ title: 'Reward', value: `0 ${rewardSymbol}`, icon: rewardLogo }
	];

	let apyData;

	const getMax = async () => {
		const balance = await token.balanceOf(user);
		amount = ethers.utils.formatUnits(balance);
	};

	const number = (k) => Number(ethers.utils.formatUnits(k));

	const getStakeStats = async () => {
		const stake = await contract.getStake(user);
		const reward = await contract.getRewardSize(user).catch(() => 0);
		data = [
			{
				title: 'Your stake',
				value: `${ethers.utils.formatUnits(stake)} ${stakeSymbol}`,
				icon: stakeLogo
			},
			{
				title: 'Reward',
				value: `${ethers.utils.formatUnits(reward)} ${rewardSymbol}`,
				icon: rewardLogo
			}
		];
		const daysTotal = (unlockTime - start.valueOf()) / 86400000;
		let daily = 0;
		if (stake.gt(0)) {
			daily = number(reward) / daysTotal;
		} else {
			const stakePool = await token.balanceOf(address);
			const rewardPool = await rewardToken.balanceOf(address);
			daily = number(rewardPool) / number(stakePool) / daysTotal;
		}
		apyData = [
			{ title: 'Daily', value: `${daily.toFixed(4)} ${rewardSymbol}`, icon: rewardLogo },
			{ title: 'Weekly', value: `${(daily * 7).toFixed(4)} ${rewardSymbol}`, icon: rewardLogo },
			{ title: 'Monthly', value: `${(daily * 30).toFixed(4)} ${rewardSymbol}`, icon: rewardLogo }
		];
	};

	const onProvider = async () => {
		provider = new ethers.providers.Web3Provider($wallet.provider);
		user = $wallet.accounts[0].address;
		signer = provider.getSigner(user);
		contract = new ethers.Contract(address, abi, signer);
		const stakeTokenAddress = await contract.getStakingToken();
		const rewardTokenAddress = await contract.getRewardToken();
		token = new ethers.Contract(stakeTokenAddress, tokenAbi.abi, signer);
		rewardToken = new ethers.Contract(rewardTokenAddress, tokenAbi.abi, signer);
		unlockTime = (await contract.getUnlockTime()) * 1000;
		getStakeStats();
	};

	const toggleStake = () => (showStake = !showStake);

	const stake = async () => {
		await token.approve(address, ethers.utils.parseUnits(amount.toString()));
		await contract.stake(ethers.utils.parseUnits(amount.toString()));
	};

	const unstake = async () => {
		await contract.unstake();
	};

	const onStake = async () => {
		if (amount.toString() === '0') {
			return toast.error('Must stake more than 0 tokens!');
		}
		busy = true;
		await toast
			.promise(stake(), {
				loading: 'Staking...',
				success: 'Staking successful!',
				error: 'There was an issue staking your tokens!'
			})
			.catch(() => null);
		busy = false;
		getStakeStats();
	};

	const onUnstake = async () => {
		busy = true;
		await toast
			.promise(unstake(), {
				loading: 'Unstaking...',
				success: 'Unstaking successful!',
				error: 'There was an issue unstaking your tokens!'
			})
			.catch(() => null);
		busy = false;
		getStakeStats();
	};

	$: if (address && $wallet?.provider) onProvider();

	onMount(() => {
		const interval = setInterval(getStakeStats, 20000);
		return () => {
			clearInterval(interval);
		};
	});
</script>

<div class="container">
	<Card>
		<div class="inner">
			<h4>{title}</h4>
			<div class="amount">
				<div class="field-wrap">
					<NumberInput bind:value={amount} placeholder="Tokens to stake" label="Amount" />
				</div>
				<Button on:click={getMax}>Max</Button>
			</div>
			<div class="buttons">
				<Button fullWidth disabled={busy} on:click={toggleStake}>
					<span class="info-button">
						{#if showStake}
							<Calculator /> APY
						{:else}
							<Coins /> Show stake
						{/if}
					</span>
				</Button>
				{#if unlockTime > new Date().valueOf()}
					<Button fullWidth disabled={busy} on:click={onStake}>Stake</Button>
				{:else if unlockTime}
					<Button fullWidth disabled={busy} on:click={onUnstake}>Unstake</Button>
				{/if}
			</div>
			{#if data && showStake}
				<Table {data} />
			{/if}
			{#if apyData && !showStake}
				<Table data={apyData} />
			{/if}
		</div>
	</Card>
</div>

<style>
	.amount {
		display: flex;
		gap: 1em;
		flex-wrap: wrap;
	}
	.field-wrap {
		flex: 1;
	}
	.inner {
		padding: 1em;
		display: flex;
		gap: 1em;
		flex-direction: column;
	}
	h4 {
		margin: 0;
	}
	.buttons {
		display: flex;
		gap: 1em;
	}
	.info-button {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 0.5em;
	}
	.info-button :global(svg) {
		height: 1em;
		fill: currentColor;
	}
</style>
