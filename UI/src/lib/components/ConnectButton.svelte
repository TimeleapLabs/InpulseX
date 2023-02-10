<script>
	import { onboard } from '../onboard';
	import { wallet } from '../../stores/wallet';
	import { onMount } from 'svelte';

	import Button from './Button.svelte';

	export let fullWidth;

	const connect = async () => {
		if ($wallet?.provider) {
			await onboard.disconnectWallet({ label: $wallet.label });
		} else {
			await onboard.connectWallet();
		}
	};

	const wallets = onboard.state.select('wallets');
	const { unsubscribe } = wallets.subscribe((update) => ([$wallet] = update));

	const addressOf = (wallet) =>
		wallet.accounts[0].address.slice(0, 5) + '...' + wallet.accounts[0].address.slice(-4);

	onMount(() => () => {
		try {
			unsubscribe();
		} catch (error) {}
	});
</script>

<Button {fullWidth} on:click={connect}>
	{#if $wallet?.provider}
		Disconnect - {addressOf($wallet)}
	{:else}
		Connect Wallet
	{/if}
</Button>
