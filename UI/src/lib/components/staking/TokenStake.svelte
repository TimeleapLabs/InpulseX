<script>
	import Card from '../Card.svelte';
	import Button from '../Button.svelte';
	import ButtonGroup from '../ButtonGroup.svelte';
	import NumberInput from '../NumberInput.svelte';
	import Table from '../Table.svelte';

	import { wallet } from '../../../stores/wallet';
	import { ethers } from 'ethers';

	import abi from '../../abi/staking/contracts/staking/ERC20.sol/ERC20StakerERC20Rewarder.json';
	import tokenAbi from '../../abi/staking/contracts/interfaces/IERC20.sol/IERC20.json';

	export let title;
	export let stakeToken;
	export let address;

	let contract, token, provider, user, signer;
	let amount = 0;
	let currentStake = 0;

	const onProvider = async () => {
		provider = new ethers.providers.Web3Provider($wallet.provider);
		user = $wallet.accounts[0].address;
		signer = provider.getSigner(user);
		contract = new ethers.Contract(address, abi, signer);
		token = new ethers.Contract(stakeToken, tokenAbi, signer);
	};

	$: if (stakeToken && address && $wallet?.provider) onProvider();

	const getMax = async () => {
		const balance = await contract.balanceOf(user);
		amount = ethers.utils.formatUnits(balance);
	};

	let data = [
		{ title: 'Your stake', value: '0 IPX' },
		{ title: 'Reward', value: '0 BUSD' }
	];

	const getStakeStats = async () => {
		const stake = await contract.getStake(user);
		const reward = await contract.getRewardSize(user);
		data = [
			{ title: 'Your stake', value: `${ethers.utils.formatUnits(stake)} IPX` },
			{ title: 'Reward', value: `${ethers.utils.formatUnits(reward)} BUSD` }
		];
	};

	$: if (user && contract) getStakeStats();
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
			<ButtonGroup>
				<Button fullWidth>Stake</Button>
			</ButtonGroup>
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
