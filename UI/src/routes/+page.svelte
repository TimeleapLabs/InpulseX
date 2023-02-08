<script>
	import Card from '../lib/components/Card.svelte';
	import Button from '../lib/components/Button.svelte';
	import TextInput from '../lib/components/TextInput.svelte';
</script>

<div class="container">
	<Card>
		<div class="inner">
			<h4>This is a test</h4>
			<TextInput placeholder="Test input" />
			<Button>Press here</Button>
		</div>
	</Card>
</div>

<style>
	.container {
		max-width: 440px;
		margin: 5em auto;
	}
	.inner {
		padding: 2em 2em;
		text-align: center;
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
		margin-bottom: 0.5em;
		font-weight: 400;
		font-size: 1.45em;
		text-transform: uppercase;
	}
</style>
