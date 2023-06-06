<script>
	import Card from '../Card.svelte';
	import NumberInput from '../NumberInput.svelte';
	import Table from '../Table.svelte';

	import { wallet } from '../../../stores/wallet';
	import { ethers } from 'ethers';
	import { onMount } from 'svelte';
	import { chainToId, onboard } from '$lib/onboard';
	import { fade } from 'svelte/transition';
	import Confetti from 'svelte-confetti';

	import toast from 'svelte-french-toast';

	import abi from '../../abi/staking/contracts/staking/ERC1363.sol/ERC1363StakerERC20Rewarder.json';
	import tokenAbi from '@openzeppelin/contracts/build/contracts/IERC1363.json';

	import Calculator from '../../icons/calculator.svelte';
	import Coins from '../../icons/coins.svelte';
	import Title from '../Title.svelte';
	import FancyButton from '../FancyButton.svelte';
	import Select from '../Select.svelte';

	export let title;
	export let addresses;
	export let stakeSymbol = 'IPX';
	export let stakeLogo = '';
	export let rewardSymbol = 'BUSD';
	export let rewardLogo = '';
	export let start;
	export let unlockTime = null;
	export let userApy = 0;
	export let chain = 'binance';

	let confetti = false;
	let contract, token, rewardToken, provider, user, signer;
	let amount = 0;
	let busy = false;
	let showStake = true;
	let contracts;
	let address;

	let data = [
		{ title: 'Your stake', value: `0 ${stakeSymbol}`, icon: stakeLogo },
		{ title: 'Rewards at Unlock', value: `0 ${rewardSymbol}`, icon: rewardLogo }
	];

	let apyData;

	const getMax = async () => {
		const balance = await token.balanceOf(user);
		amount = ethers.utils.formatUnits(balance);
	};

	const number = (k) => Number(ethers.utils.formatUnits(k));

	const getStakeStats = async () => {
		if (!contract) {
			return;
		}
		const stake = await contract.getStake(user);
		const reward = await contract.getRewardSize(user).catch(() => 0);
		data = [
			{
				title: 'Your stake',
				value: `${ethers.utils.formatUnits(stake)} ${stakeSymbol}`,
				icon: stakeLogo
			},
			{
				title: 'Rewards at Unlock',
				value: parseFloat(ethers.utils.formatUnits(reward)),
				countUp: true,
				suffix: rewardSymbol,
				icon: rewardLogo
			}
		];
		const daysTotal = (unlockTime - start.valueOf()) / 86400000;
		if (stake.gt(0)) {
			userApy = number(reward) / daysTotal;
		} else {
			userApy = 0;
		}
		apyData = [
			{ title: 'Daily', value: userApy, countUp: true, suffix: rewardSymbol, icon: rewardLogo },
			{
				title: 'Weekly',
				value: userApy * 7,
				countUp: true,
				suffix: rewardSymbol,
				icon: rewardLogo
			},
			{
				title: 'Monthly',
				value: userApy * 30,
				countUp: true,
				suffix: rewardSymbol,
				icon: rewardLogo
			}
		];
	};

	const onContract = async () => {
		const stakeTokenAddress = await contract.getStakingToken();
		const rewardTokenAddress = await contract.getRewardToken();
		token = new ethers.Contract(stakeTokenAddress, tokenAbi.abi, signer);
		rewardToken = new ethers.Contract(rewardTokenAddress, tokenAbi.abi, signer);
		unlockTime = (await contract.getUnlockTime()) * 1000;
		getStakeStats();
	};

	const onAddress = () => {
		contract = new ethers.Contract(address, abi, signer);
		onContract();
	};

	const onProvider = async () => {
		await onboard.setChain({ chainId: chainToId[chain] });
		provider = new ethers.providers.Web3Provider($wallet.provider);
		user = $wallet.accounts[0].address;
		signer = provider.getSigner(user);
		contracts = await Promise.all(
			addresses.map(async (address) => {
				const contract = new ethers.Contract(address, abi, signer);
				const unlockTime = (await contract.getUnlockTime()) * 1000;
				const unlock = new Date(unlockTime).toLocaleDateString();
				return { value: address, title: `Unlock at ${unlock}` };
			})
		);
		address = contracts[0].value;
	};

	$: if (address) onAddress();

	const stake = async () => {
		const tx = await token['transferAndCall(address,uint256)'](
			contract.address,
			ethers.utils.parseUnits(amount.toString())
		);
		await tx.wait(1);
	};

	const unstake = async () => {
		await contract.unstake();
	};

	const toggleStake = () => (showStake = !showStake);

	const onStake = async () => {
		if (amount.toString() === '0') {
			return toast.error('Must stake more than 0 tokens!');
		}
		busy = true;
		let err = false;
		await toast
			.promise(stake(), {
				loading: 'Staking...',
				success: 'Staking successful!',
				error: 'There was an issue staking your tokens!'
			})
			.catch(() => {
				err = true;
			});
		busy = false;
		if (!err) {
			getStakeStats();
			confetti = true;
			setTimeout(() => {
				confetti = false;
			}, 10000);
		}
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

	$: if ($wallet?.provider) onProvider();

	onMount(() => {
		const interval = setInterval(getStakeStats, 30000);
		return () => {
			clearInterval(interval);
		};
	});
</script>

<div class="container">
	{#if confetti}
		<div class="confetti" out:fade>
			<Confetti
				x={[-5, 5]}
				y={[0, 0.1]}
				delay={[500, 2000]}
				infinite
				duration="5000"
				amount="200"
				fallDistance="100vh"
			/>
		</div>
	{/if}
	<Card isPrimary={false}>
		<div class="inner">
			<Title as="h3">{title}</Title>
			<div class="amount">
				<div class="field-wrap">
					<NumberInput fullWidth bind:value={amount} placeholder="Tokens to stake" label="Amount" />
				</div>
				<FancyButton on:click={getMax}>Max</FancyButton>
			</div>
			<div class="duration">
				<Select options={contracts} bind:value={address} label="Duration" />
			</div>
			<div class="buttons">
				<FancyButton fullWidth disabled={busy} on:click={toggleStake}>
					<span class="info-button">
						{#if showStake}
							<Calculator /> APY
						{:else}
							<Coins /> Show stake
						{/if}
					</span>
				</FancyButton>
				{#if unlockTime > new Date().valueOf()}
					<FancyButton {confetti} fullWidth disabled={busy} on:click={onStake}>Stake</FancyButton>
				{:else if unlockTime}
					<FancyButton fullWidth disabled={busy} on:click={onUnstake}>Unstake</FancyButton>
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
	.container {
		width: 100%;
		height: 100%;
	}
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
	@media only screen and (max-width: 600px) {
		.inner {
			padding: 0;
		}
		.buttons {
			flex-wrap: wrap;
		}
	}
	.confetti {
		position: fixed;
		top: -50px;
		left: 0;
		height: 100vh;
		width: 100vw;
		display: flex;
		justify-content: center;
		overflow: hidden;
		pointer-events: none;
	}
</style>
