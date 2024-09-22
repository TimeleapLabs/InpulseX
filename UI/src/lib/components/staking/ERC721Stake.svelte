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

	import abi from '../../abi/staking/contracts/staking/UniSwapNFT.sol/UniSwapStakerERC20Rewarder.json';
	import tokenAbi from '../../abi/staking/contracts/staking/UniSwapNFT.sol/INonFungiblePositionManager.json';
	import rewardAbi from '@openzeppelin/contracts/build/contracts/IERC20.json';

	import Calculator from '../../icons/calculator.svelte';
	import Coins from '../../icons/coins.svelte';
	import Chart from '../icons/Chart.svelte';
	import Title from '../Title.svelte';
	import FancyButton from '../FancyButton.svelte';
	import Select from '../Select.svelte';

	import { publicRpcs } from '../../onboard';
	import { getIpxEthPrice } from '../../uniswap';

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
	let id = 0;
	let busy = false;
	let showStake = true;
	let showEarnings = false;
	let showApr = false;
	let contracts;
	let address;

	const publicProvider = new ethers.providers.JsonRpcProvider(publicRpcs[chain]);

	let data = [
		{ title: 'Your stake', value: `0 ${stakeSymbol}`, icon: stakeLogo },
		{ title: 'Rewards at Unlock', value: `0 ${rewardSymbol}`, icon: rewardLogo }
	];

	let earningData;

	const number = (k) => Number(ethers.utils.formatUnits(k));

	const getStakeStats = async () => {
		if (!contract) {
			return;
		}
		const stakeIds = await contract.getStakeIds(user);
		const stake = stakeIds.length;
		const reward = await contract.getRewardSize(user).catch(() => 0);
		data = [
			{
				title: 'Your stake',
				value: `${stake} ${stakeSymbol}`,
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
		if (stake > 0) {
			userApy = number(reward) / daysTotal;
		} else {
			userApy = 0;
		}
		earningData = [
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
		token = new ethers.Contract(stakeTokenAddress, tokenAbi, signer);
		rewardToken = new ethers.Contract(rewardTokenAddress, rewardAbi.abi, signer);
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
		const approveTx = await token.setApprovalForAll(address, true);
		await approveTx.wait(1);
		const stakeTx = await contract.stake(id.toString());
		await stakeTx.wait(1);
	};

	const unstake = async () => {
		await contract.unstake();
	};

	const doShowUserEarnings = () => {
		[showEarnings, showApr, showStake] = [true, false, false];
	};

	const doShowUserStake = () => {
		[showEarnings, showApr, showStake] = [false, false, true];
	};

	const doShowApr = () => {
		[showEarnings, showApr, showStake] = [false, true, false];
	};

	const onStake = async () => {
		if (!id) {
			return toast.error('NFT ID is needed!');
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

	let poolApr = '7%';

	const SECONDS_IN_YEAR = 365 * 86400;
	const USER_STAKE = 1e18;

	const getPoolApr = async () => {
		const aprs = [];
		for (const address of addresses) {
			const contract = new ethers.Contract(address, abi, publicProvider);
			const rewardSize = await contract.getTotalPoolRewards();
			const unlockTime = Number(await contract.getUnlockTime());
			const timeLeft = unlockTime - new Date().valueOf() / 1000;
			const poolWeight = await contract.getTotalPoolWeight();
			const userWeight = USER_STAKE * timeLeft;
			const userShare = userWeight / poolWeight;
			const rewardShare = userShare * Number(rewardSize);
			const ipxPrice = await getIpxEthPrice();
			const rewardsInEth = (rewardShare / 1e18) * ipxPrice;
			const percentEarned = rewardsInEth / (USER_STAKE / 1e18);
			const apr = (SECONDS_IN_YEAR / timeLeft) * percentEarned;
			const poolApr = `${(apr * 100).toFixed(2)}%`;
			aprs.push({ poolApr, unlock: new Date(unlockTime * 1000) });
		}
		poolApr = aprs.map(({ poolApr, unlock }) => ({
			title: `Unlock at ${unlock.toLocaleDateString()}`,
			value: poolApr,
			suffix: rewardSymbol,
			icon: rewardLogo
		}));
	};

	onMount(() => {
		getPoolApr();
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
			<div class="id">
				<div class="field-wrap">
					<NumberInput fullWidth bind:value={id} placeholder="NFT to stake" label="NFT ID" />
				</div>
			</div>
			<div class="duration">
				<Select options={contracts} bind:value={address} label="Duration" />
			</div>
			<div class="buttons">
				{#if earningData}
					<FancyButton fullWidth disabled={busy} on:click={doShowUserEarnings}>
						<span class="info-button">
							<Chart /> Earnings
						</span>
					</FancyButton>
				{/if}
				{#if poolApr}
					<FancyButton fullWidth disabled={busy} on:click={doShowApr}>
						<span class="info-button">
							<Calculator /> APR
						</span>
					</FancyButton>
				{/if}
				{#if !unlockTime}
					<FancyButton fullWidth disabled={busy} on:click={doShowUserStake}>
						<span class="info-button">
							<Coins /> Show Stake
						</span>
					</FancyButton>
				{/if}
			</div>
			<div class="buttons">
				{#if unlockTime}
					<FancyButton fullWidth disabled={busy} on:click={doShowUserStake}>
						<span class="info-button">
							<Coins /> Show Stake
						</span>
					</FancyButton>
				{/if}
				{#if unlockTime > new Date().valueOf()}
					<FancyButton {confetti} primary fullWidth disabled={busy} on:click={onStake}>
						Stake
					</FancyButton>
				{:else if unlockTime}
					<FancyButton primary fullWidth disabled={busy} on:click={onUnstake}>Unstake</FancyButton>
				{/if}
			</div>
			{#if data && showStake}
				<Table {data} />
			{/if}
			{#if earningData && showEarnings}
				<Table data={earningData} />
			{/if}
			{#if poolApr && showApr}
				<Table data={poolApr} />
			{/if}
		</div>
	</Card>
</div>

<style>
	.container {
		width: 100%;
		height: 100%;
	}
	.id {
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
