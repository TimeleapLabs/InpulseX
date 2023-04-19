<script>
	import Highlight from '../Highlight.svelte';
	import Paragraph from '../Paragraph.svelte';
	import Title from '../Title.svelte';
</script>

<div class="utilities">
	<div class="title">
		<Title as="h2" centered>
			<Highlight>Ecosystem</Highlight>
			Pillars
		</Title>
	</div>

	<div class="grid">
		<div class="card" style="--image: url('/images/treasure-chest.png'); --main-color: #a942aa;">
			<div class="description">
				<Title as="h4">TheNFTX</Title>
				<Paragraph>
					TheNFTX is the leading platform for visionary artists aligned with the consciousness
					expansion movement, serving as a crucial NFT cornerstone in the InpulseX project.
				</Paragraph>
			</div>
		</div>

		<div class="card" style="--image: url('/images/gamepad.png'); --main-color: #ac8f4b;">
			<div class="description">
				<Title as="h4">TheGameX</Title>
				<Paragraph>
					TheGameX is a vital pillar for InpulseX, driving user engagement, strengthening IPX token
					utility, and cultivating a thriving community invested in the Starseed game and broader
					ecosystem.
				</Paragraph>
			</div>
		</div>

		<div class="card" style="--image: url('/images/palace.jpg'); --main-color: #66aeac;">
			<div class="description">
				<Title as="h4">TheAcademiaX</Title>
				<Paragraph>
					TheAcademiaX connects industry experts with community members, offering knowledge sharing,
					networking opportunities, educational content, and community empowerment.
				</Paragraph>
			</div>
		</div>

		<div class="card" style="--image: url('/images/spaceship.png'); --main-color: #a942aa;">
			<div class="description">
				<Title as="h4">Xstronaut Membership Club</Title>
				<Paragraph>
					XMC is a passionate club offering exclusive benefits, attracting members and driving
					ecosystem growth. It includes tiered benefits, token launches, VC deals, personalised
					avatars, one-on-one meetings with the IPX management team, and much more.
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
		font-size: 2em;
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
	.description :global(h4) {
		font-size: 2em;
		margin-bottom: 0.5em;
	}
	@media only screen and (max-width: 1440px) {
		.utilities {
			padding: 6em 4em;
		}
	}
	@media only screen and (max-width: 720px) {
		.utilities {
			padding: 1em 2em;
		}
		.grid {
			grid-template-columns: 1fr;
			grid-template-rows: 500px 500px 500px 500px;
		}
	}
</style>
