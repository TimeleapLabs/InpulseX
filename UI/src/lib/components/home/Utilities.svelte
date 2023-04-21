<script>
	import Highlight from '../Highlight.svelte';
	import Paragraph from '../Paragraph.svelte';
	import Title from '../Title.svelte';
	import { slide } from 'svelte/transition';
	import ChevronsUp from '../icons/ChevronsUp.svelte';

	let showOne = false;
	let showTwo = false;
	let showThree = false;
	let showFour = false;

	const onMouseEnter = (n) => () => {
		if (n === 1) {
			showOne = true;
		} else if (n === 2) {
			showTwo = true;
		} else if (n === 3) {
			showThree = true;
		} else if (n === 4) {
			showFour = true;
		}
	};

	const onMouseLeave = (n) => () => {
		if (n === 1) {
			showOne = false;
		} else if (n === 2) {
			showTwo = false;
		} else if (n === 3) {
			showThree = false;
		} else if (n === 4) {
			showFour = false;
		}
	};
</script>

<div class="utilities" id="pillars">
	<div class="title">
		<Title as="h2" centered>
			<Highlight>Ecosystem</Highlight>
			Pillars
		</Title>
	</div>

	<div class="grid">
		<div
			class="card"
			style="--image: url('/images/treasure-chest.png'); --main-color: #a942aa;"
			on:mouseenter={onMouseEnter(1)}
			on:mouseleave={onMouseLeave(1)}
		>
			<div class="description">
				<Title as="h4">
					<img
						src="/images/partners/thenftx.png"
						height="28em"
						alt="TheNFTX"
						style="margin-bottom: -8px;"
					/>
				</Title>
				<div class="chevron">
					<ChevronsUp width={'20px'} height={'20px'} />
				</div>
				{#if showOne}
					<div transition:slide={{ duration: 300 }}>
						<Paragraph>
							TheNFTX serves as a crucial NFT cornerstone within the InpulseX ecosystem, striving to
							establish itself as the premier platform for forward-thinking artists whose creations
							resonate with the consciousness expansion movement, space exploration and pioneering
							technologies.
						</Paragraph>
					</div>
				{/if}
			</div>
		</div>

		<div
			class="card"
			style="--image: url('/images/gamepad.png'); --main-color: #ac8f4b;"
			on:mouseenter={onMouseEnter(2)}
			on:mouseleave={onMouseLeave(2)}
		>
			<div class="description">
				<Title as="h4">
					<img src="/images/partners/thegamex.png" height="16em" alt="TheGameX" />
				</Title>
				<div class="chevron">
					<ChevronsUp width={'20px'} height={'20px'} />
				</div>
				{#if showTwo}
					<div transition:slide={{ duration: 300 }}>
						<Paragraph>
							TheGameX pillar is paramount to the entire ecosystem. It is a major driver of user
							engagement, community growth, and long-term sustainability by focusing on developing
							and managing the Starseed game and associated activities.
						</Paragraph>
					</div>
				{/if}
			</div>
		</div>

		<div
			class="card"
			style="--image: url('/images/spaceship.png'); --main-color: #66aeac;"
			on:mouseenter={onMouseEnter(3)}
			on:mouseleave={onMouseLeave(3)}
		>
			<div class="description">
				<Title as="h4">
					<img
						src="/images/partners/theacademiax.png"
						height="14em"
						alt="TheAcademiaX"
						style="margin-bottom: -4px;"
					/>
				</Title>
				<div class="chevron">
					<ChevronsUp width={'20px'} height={'20px'} />
				</div>
				{#if showThree}
					<div transition:slide={{ duration: 300 }}>
						<Paragraph>
							The AcademiaX pillar plays a unique and important role, dedicated to enriching the
							community by bringing together individuals passionate about innovation, exploration,
							and knowledge.
						</Paragraph>
					</div>
				{/if}
			</div>
		</div>

		<div
			class="card"
			style="--image: url('/images/palace.jpg'); --main-color: #a942aa;"
			on:mouseenter={onMouseEnter(4)}
			on:mouseleave={onMouseLeave(4)}
		>
			<div class="description">
				<Title as="h4">Xstronaut Membership Club</Title>
				<div class="chevron">
					<ChevronsUp width={'20px'} height={'20px'} />
				</div>
				{#if showFour}
					<div transition:slide={{ duration: 300 }}>
						<Paragraph>
							The X.M.C. is an exciting and vibrant exclusive club where individuals with a shared
							passion enjoy unique benefits and fantastic opportunities. As a member, you can take
							advantage of a wide range of perks, depending on your membership tier.
						</Paragraph>
					</div>
				{/if}
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
		grid-template-rows: 320px 320px;
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
		position: relative;
		width: 100%;
		padding: 1em 2em;
		border: 1px solid var(--main-color);
		backdrop-filter: blur(24px);
		-webkit-backdrop-filter: blur(24px);
		border-top-left-radius: 4em;
		border-top-right-radius: 4em;
		box-shadow: inset 0px 0px 22px 0px rgba(255, 255, 255, 0.4),
			inset 0px -8px 12px 0px var(--main-color);
	}
	.chevron {
		position: absolute;
		top: 1.5em;
		right: 3em;
		opacity: 0.7;
	}
	.description :global(h4) {
		font-size: 2em;
		margin-bottom: 0.5em;
		text-align: center;
		font-family: 'Groningen';
		font-size: 1.4em;
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
			grid-template-rows: 320px 320px 320px 320px;
		}
		.title {
			font-size: 1em;
		}
		.description :global(h4) {
			font-size: 0.8em;
		}
	}
</style>
