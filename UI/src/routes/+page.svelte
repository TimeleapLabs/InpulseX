<script>
	import Card from '../lib/components/Card.svelte';
	import Button from '../lib/components/Button.svelte';
	import TextInput from '../lib/components/TextInput.svelte';
	import NumberInput from '../lib/components/NumberInput.svelte';
	import Table from '../lib/components/Table.svelte';
	import ButtonGroup from '../lib/components/ButtonGroup.svelte';
	import Select from '../lib/components/Select.svelte';
	import ConnectButton from '../lib/components/ConnectButton.svelte';
	import ERC20Stake from '../lib/components/staking/ERC20Stake.svelte';
	import Choice from '../lib/components/nft/Choice.svelte';

	import { Toaster } from 'svelte-french-toast';

	const data = [
		{ title: 'Your stake', value: '123456 IPX' },
		{ title: 'Reward', value: '123 BUSD' }
	];

	const options = [
		{ title: 'BSC', value: 'bsc' },
		{ title: 'Ethereum', value: 'ethereum' }
	];
</script>

<div class="container">
	<Card>
		<div class="inner">
			<h4>This is a test</h4>
			<NumberInput placeholder="Tokens" label="Amount" />
			<TextInput placeholder="Test input" label="Label" />
			<Select {options} label="From Chain" />
			<ButtonGroup>
				<Button>Stake</Button>
				<Button>UnStake</Button>
				<ConnectButton fullWidth />
			</ButtonGroup>
			<Table {data} />
		</div>
	</Card>
	<Card>
		<Choice address="0xa9a6A3626993D487d2Dbda3173cf58cA1a9D9e9f" maxMinted={1000} />
	</Card>
	<ERC20Stake title="Stake IPX" />
	<Toaster />
</div>

<style>
	.container {
		max-width: 440px;
		margin: 5em auto;
		display: flex;
		flex-direction: column;
		gap: 2em;
	}
	.inner {
		padding: 1em;
		display: flex;
		gap: 1em;
		flex-direction: column;
	}
	:global(body) {
		background: #111;
		color: #fff;
		font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu,
			Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	}
	h4 {
		margin: 0;
	}
</style>
