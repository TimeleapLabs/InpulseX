<script>
	import Highlight from '../Highlight.svelte';
	import Paragraph from '../Paragraph.svelte';
	import Title from '../Title.svelte';
</script>

<div class="utilities">
	<div class="title">
		<Title as="h2" centered>Utilities for <br /><Highlight>$IPX Tokens</Highlight></Title>
	</div>

	<div class="grid">
		<div class="card" style="--image: url('/images/treasure-chest.png'); --main-color: #a942aa;">
			<div class="description">
				<Title as="h4">Rewards</Title>
				<Paragraph>Simply by holding, you earn rewards in a stable coin.</Paragraph>
			</div>
		</div>

		<div class="card" style="--image: url('/images/spaceship.png'); --main-color: #e49456;">
			<div class="description">
				<Title as="h4">Collectable and in-game NFTs</Title>
				<Paragraph>
					Super-exciting Airdrops! The most loyal holders will earn a chance to receive rare in-game
					playable NFTs & collectables.
				</Paragraph>
			</div>
		</div>

		<div class="card" style="--image: url('/images/gamepad.png'); --main-color: #ac8f4b;">
			<div class="description">
				<Title as="h4">Play-to-earn game</Title>
				<Paragraph>
					$IPX token will be used as in-game currency foor our play-to-earn NFT game, to be released
					in 2023.
				</Paragraph>
			</div>
		</div>

		<div class="card" style="--image: url('/images/palace.png'); --main-color: #66aeac;">
			<div class="description">
				<Title as="h4">Governance</Title>
				<Paragraph>
					The governance token holders can influence decisions by exercising their voting right to
					shape the platform.
				</Paragraph>
			</div>
		</div>
	</div>

	<div class="gradient" />
</div>

<!-- inset 0px 0px 12px 1px rgba(255, 255, 255, 0.4), -->
<style>
	.utilities {
		position: relative;
		box-sizing: border-box;
		padding: 4em 24em;
		background-color: #140f29;
	}

	.title {
		position: relative;
		z-index: 2;
	}

	.gradient {
		position: absolute;
		top: 0;
		left: 0;
		margin-top: -25em;
		z-index: 0;
		width: 100%;
		height: 100%;
		background: radial-gradient(circle, rgba(220, 21, 164, 0.65) 0%, rgba(0, 0, 0, 0) 50%);
	}

	.grid {
		display: grid;
		grid-template-rows: 500px 500px;
		grid-template-columns: 1fr 1fr;
		grid-gap: 4rem;
		padding: 4em 0;
	}

	.card {
		width: 100%;
		display: flex;
		align-items: flex-end;
		border-top-left-radius: 4em;
		border-top-right-radius: 4em;
		background-image: var(--image);
		background-size: cover;
		background-position: center;
		border-bottom: 8px solid var(--main-color);
		box-shadow: inset 0px 0px 22px 0px rgba(255, 255, 255, 0.4);
		z-index: 2;
	}

	.description {
		width: 100%;
		padding: 1em 2em;
		border: 1px solid var(--main-color);
		backdrop-filter: blur(24px);
		border-top-left-radius: 4em;
		border-top-right-radius: 4em;
		box-shadow: inset 0px 0px 22px 0px rgba(255, 255, 255, 0.4),
			inset 0px -8px 12px 0px var(--main-color);
	}
</style>
