<script>
	let email;
	let subscribed = false;

	const subscribe = async () => {
		subscribed = true;
		await fetch('/subscribe', {
			method: 'POST',
			body: JSON.stringify({ email }),
			headers: { 'Content-Type': 'application/json' }
		});
	};
</script>

<div class="subscribe">
	<div class="form">
		<div class="header">InpulseX FZCO</div>
		<div class="message">
			{#if subscribed}
				Thanks for subscribing!
			{:else}
				Don't miss out, stay updated
			{/if}
		</div>
		{#if !subscribed}
			<input type="email" bind:value={email} placeholder="Email" />
			{#if email}
				<button on:click={subscribe}> Subscribe </button>
			{/if}
		{/if}
	</div>
</div>

<style>
	.subscribe {
		display: flex;
		flex-direction: column;
		padding: 4em;
		position: relative;
		box-sizing: border-box;
		background-color: #140f29;
		align-items: center;
		justify-content: center;
	}
	.subscribe > * {
		position: relative;
		z-index: 1;
	}
	.form {
		background: url(/images/subscribe.png);
		background-size: cover;
		border-radius: 2em;
		width: 80%;
		min-height: 320px;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 1em;
		flex-direction: column;
	}
	.header {
		color: #ccc;
	}
	.message {
		font-family: 'Bebas', sans-serif;
		font-size: 2em;
		text-shadow: 0px 2px rgba(0, 0, 0, 0.4);
	}
	input {
		border-radius: 2em;
		border: 1px solid #fff;
		background: transparent;
		backdrop-filter: blur(40px);
		width: 50%;
		padding: 1em 2em;
		color: #fff;
		box-shadow: inset 0px 0px 0.75em 0.25em rgba(255, 255, 255, 0.4);
	}
	button {
		background: #fff;
		border: none;
		border-radius: 0.5em;
		padding: 0.5em 1em;
		color: var(--primary-blue);
	}
	@media only screen and (max-width: 800px) {
		.form {
			width: 95%;
			padding: 1em;
			box-sizing: border-box;
			text-align: center;
		}
		.subscribe {
			display: flex;
			flex-direction: column;
			padding: 4em 2em;
		}
	}
	@media only screen and (max-width: 400px) {
		.form {
			width: 100%;
			padding: 1em;
		}
		input {
			width: 80%;
		}
	}
</style>
