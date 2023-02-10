<script>
	import Card from '../Card.svelte';
	import Button from '../Button.svelte';
	import NumberInput from '../NumberInput.svelte';
	import Table from '../Table.svelte';

	import { wallet } from '../../../stores/wallet';
	import { ethers } from 'ethers';
	import toast from 'svelte-french-toast';

	import abi from '../../abi/staking/contracts/staking/ERC20.sol/ERC20StakerERC20Rewarder.json';
	import tokenAbi from '../../abi/staking/contracts/interfaces/IERC20.sol/IERC20.json';

	export let title;
	export let address;
	export let stakeSymbol = 'IPX';
	export let rewardSymbol = 'BUSD';

	let contract, token, provider, user, signer;
	let amount = 0;
	let unlockTime;
	let stakingWindow;
	let busy = false;

	let data = [
		{ title: 'Your stake', value: `0 ${stakeSymbol}` },
		{ title: 'Reward', value: `0 ${rewardSymbol}` }
	];

	const getMax = async () => {
		const balance = await token.balanceOf(user);
		amount = ethers.utils.formatUnits(balance);
	};

	const getStakeStats = async () => {
		const stake = await contract.getStake(user);
		const reward = await contract.getRewardSize(user);
		data = [
			{ title: 'Your stake', value: `${ethers.utils.formatUnits(stake)} ${stakeSymbol}` },
			{ title: 'Reward', value: `${ethers.utils.formatUnits(reward)} ${rewardSymbol}` }
		];
	};

	const onProvider = async () => {
		provider = new ethers.providers.Web3Provider($wallet.provider);
		user = $wallet.accounts[0].address;
		signer = provider.getSigner(user);
		contract = new ethers.Contract(address, abi, signer);
		const stakeToken = await contract.getStakingToken();
		token = new ethers.Contract(stakeToken, tokenAbi, signer);
		unlockTime = (await contract.getUnlockTime()) * 1000;
		stakingWindow = (await contract.getStakingWindow()) * 1000;
		getStakeStats();
	};

	const stake = async () => {
		await token.approve(address, ethers.utils.parseUnits(amount));
		await contract.stake(ethers.utils.parseUnits(amount));
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
	};

	$: if (address && $wallet?.provider) onProvider();
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
			<Button fullWidth on:click={onStake} disabled={busy}>Stake</Button>
			{#if stakingWindow > new Date().valueOf()}
				<Button fullWidth on:click={onStake}>Stake</Button>
			{:else if unlockTime < new Date().valueOf()}
				<Button fullWidth on:click={onUnstake}>Unstake</Button>
			{/if}
			{#if data}
				<Table {data} />
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
</style>
