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
	import Chart from '../icons/Chart.svelte';
	import Title from '../Title.svelte';
	import FancyButton from '../FancyButton.svelte';
	import Select from '../Select.svelte';

	import { publicRpcs } from '../../onboard';

	export let title;
	export let addresses;
	export let names;
	export let stakeSymbol = 'IPX';
	export let stakeLogo = '';
	export let rewardSymbol = 'BUSD';
	export let rewardLogo = '';
	export let start;
	export let unlockTime = null;
	export let userApy = 0;
	export let chain = 'binance';
	export let rewards = ['0'];

	let confetti = false;
	let contract, token, rewardToken, provider, user, signer;
	let amount = 0;
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
			addresses.map(async (address, index) => {
				const contract = new ethers.Contract(address, abi, signer);
				const unlockTime = (await contract.getUnlockTime()) * 1000;
				const unlock = new Date(unlockTime).toLocaleDateString();
				const isUnlocked = unlockTime < Date.now();
				const name = names[index];
				return {
					value: address,
					title: `${name} - ${isUnlocked ? 'Unlocked' : 'Unlock'} at ${unlock}`
				};
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

	let poolApr = '7%';

	const GOLD = 1.618033988749894;
	const SECONDS_IN_YEAR = 365 * 86400;
	const USER_STAKE = 1350000;

	const getPoolApr = async () => {
		const aprs = [];
		const zipped = addresses.map((address, i) => [address, rewards[i]]);
		for (const [address, rewardSize] of zipped) {
			const contract = new ethers.Contract(address, abi, publicProvider);
			const stakeTokenAddress = await contract.getStakingToken();
			const rewardTokenAddress = await contract.getRewardToken();
			const stakeToken = new ethers.Contract(stakeTokenAddress, tokenAbi.abi, publicProvider);
			const contractBalance = await stakeToken.balanceOf(address);
			const unlockTime = Number(await contract.getUnlockTime());
			const staked =
				rewardTokenAddress === stakeTokenAddress
					? contractBalance.sub(ethers.utils.parseUnits(rewardSize))
					: contractBalance;
			const timeLeft = unlockTime - new Date().valueOf() / 1000;
			const timeSpent = (new Date().valueOf() - new Date(start).valueOf()) / 1000;
			const poolWeight = (timeLeft + timeSpent / GOLD) * Number(ethers.utils.formatUnits(staked));
			const userWeight = USER_STAKE * timeLeft;
			const userShare = userWeight / poolWeight;
			const rewardShare = userShare * Number(rewardSize);
			const percentEarned = rewardShare / USER_STAKE;
			const apr = (SECONDS_IN_YEAR / timeLeft) * percentEarned;
			const poolApr = `${(apr * 100).toFixed(2)}%`;
			aprs.push({ poolApr, unlock: new Date(unlockTime * 1000) });
		}
		poolApr = aprs.map(({ poolApr, unlock }) => {
			const isUnlocked = unlock < Date.now();
			const formattedUnlock = unlock.toLocaleDateString();
			return {
				title: `${isUnlocked ? 'Unlocked' : 'Unlock'} at ${formattedUnlock}`,
				value: poolApr,
				suffix: rewardSymbol,
				icon: rewardLogo
			};
		});
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
						{#if amount}
							{amount.toString().slice(0, 6)}{amount.toString().length > 6 ? '...' : ''}
							token{amount === 1 ? '' : 's'}
						{/if}
					</FancyButton>
				{/if}
				<FancyButton primary fullWidth disabled={busy} on:click={onUnstake}>Unstake</FancyButton>
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
