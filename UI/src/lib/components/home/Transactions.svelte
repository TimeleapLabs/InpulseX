<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
</script>

<div class="transactions">
	<div class="background" />

	<div class="title">
		<Title as="h2">Transactions</Title>
	</div>

	<div class="grid">
		<div class="clipped one" style="--image: url('/images/rewards.png'); --main-color: #a942aa;">
			<div class="content">
				<div class="glass">
					<div class="inner">
						<Title as="h3">Rewards Distribution</Title>
						<Paragraph>Just a few words as placeholder text</Paragraph>
					</div>
				</div>
			</div>
			<div class="border" />
		</div>
		<div class="clipped two" style="--image: url('/images/liquidity.png'); --main-color: #e49456;">
			<div class="content">
				<div class="glass">
					<div class="inner">
						<Title as="h3">Liquidity</Title>
						<Paragraph>Just a few words as placeholder text</Paragraph>
					</div>
				</div>
			</div>
			<div class="border" />
		</div>
		<div class="clipped three" style="--image: url('/images/game.dev.png'); --main-color: #ac8f4b;">
			<div class="content">
				<div class="glass">
					<div class="inner">
						<Title as="h3">Game Development</Title>
						<Paragraph>Just a few words as placeholder text</Paragraph>
					</div>
				</div>
			</div>
			<div class="border" />
		</div>
		<div class="clipped four" style="--image: url('/images/buyback.png'); --main-color: #66aeac;">
			<div class="content">
				<div class="glass">
					<div class="inner">
						<Title as="h3">Buyback</Title>
						<Paragraph>Just a few words as placeholder text</Paragraph>
					</div>
				</div>
			</div>
			<div class="border" />
		</div>
	</div>
</div>

<svg width="0" height="0">
	<defs>
		<clipPath id="one" clipPathUnits="objectBoundingBox">
			<path
				d="m 0.02709,4.4e-4 c 0.14872,0 0.29745,0 0.44617,0 0,0.15584 0,0.31167 0,0.46751 -0.01064,0.01224 -0.02558,0.0227 -0.0336,0.03601 0,0.16521 0,0.33041 0,0.49561 -0.14641,0 -0.29282,0 -0.43923,0 0,-0.0303 0,-0.0606 0,-0.0909 C 0.00921,0.89573 0.02171,0.88406 0.02823,0.87036 0.02785,0.58038 0.02747,0.29041 0.02709,4.4e-4 Z"
			/>
		</clipPath>
		<clipPath id="two" clipPathUnits="objectBoundingBox">
			<path
				d="m 0.03171677,0.51862777 c 0,-0.17273 0,-0.34547 0,-0.51819999599 0.145636,0 0.291272,0 0.436908,0 0,0.27675999599 0,0.55352999599 0,0.83028999599 -0.0095,0.0111 -0.02331,0.0203 -0.03013,0.0325 0,0.0454 0,0.0909 0,0.13636 -0.146023,0 -0.292045,0 -0.43806699599,0 0,-0.15022 0,-0.30044 0,-0.45066 0.010429996,-0.0101 0.020859996,-0.0202 0.031289996,-0.0303 z"
			/>
		</clipPath>
		<clipPath id="three" clipPathUnits="objectBoundingBox">
			<path
				d="m 4.332725e-4,0.90968827 c 0.008799998,-0.0105 0.0221799975,-0.0192 0.0283899975,-0.0308 0,-0.29282 0,-0.58564 0,-0.8784599975 0.148147,0 0.296293,0 0.44444,0 0,0.1556299975 0,0.3112599975 0,0.4668899975 -0.01088,0.0124 -0.0259,0.0231 -0.03419,0.0366 0,0.1652 0,0.3304 0,0.49561 -0.146215,0 -0.29243,0 -0.4386449975,0 0,-0.03 0,-0.0599 0,-0.0899 z"
			/>
		</clipPath>
		<clipPath id="four" clipPathUnits="objectBoundingBox">
			<path
				d="m 4.6679304e-4,0.54915654 c 0.010039997,-0.0116 0.024469997,-0.0214 0.031869997,-0.034 0,-0.17158 0,-0.34315 0,-0.51473000451 0.146216,0 0.292433,0 0.438649,0 0,0.27285000451 0,0.54569000451 0,0.81854000451 -0.01001,0.0159 -0.02339,0.0308 -0.03129,0.0474 0,0.0444 0,0.0888 0,0.13325 -0.146023,0 -0.292046,0 -0.438069,0 -3.86e-4,-0.15013 -7.7299692e-4,-0.30025 -0.001199997,-0.45037 z"
			/>
		</clipPath>
	</defs>
</svg>

<!-- inset 0px 0px 12px 1px rgba(255, 255, 255, 0.4), -->
<style>
	svg {
		opacity: 0;
		position: absolute;
	}
	.background {
		background: url(/images/grid.pink.png) no-repeat center center;
		background-size: contain;
		width: 100%;
		height: 100%;
		position: absolute;
		top: 0;
		left: 0;
		z-index: 0;
		opacity: 0.6;
	}
	.title {
		position: relative;
		z-index: 1;
	}
	.transactions {
		position: relative;
		box-sizing: border-box;
		padding: 4em 24em;
		background-color: #140f29;
	}

	.grid {
		display: grid;
		grid-template-rows: 500px;
		grid-template-columns: 1fr 1fr 1fr 1fr;
		padding: 4em 0;
	}

	.clipped {
		width: 300px;
		height: 564px;
		overflow: hidden;
		position: relative;
	}

	.clipped .content {
		height: calc(100% - 4px);
		width: calc(200% - 8px);
		display: flex;
		align-items: flex-end;
		background-image: var(--image);
		background-size: contain;
		background-position: left;
		z-index: 2;
		position: relative;
		margin-left: 2px;
		margin-top: 2px;
	}

	.clipped.one .border,
	.clipped.one .content {
		clip-path: url(#one);
	}
	.clipped.two .border,
	.clipped.two .content {
		clip-path: url(#two);
	}
	.clipped.three .border,
	.clipped.three .content {
		clip-path: url(#three);
	}
	.clipped.four .border,
	.clipped.four .content {
		clip-path: url(#four);
	}
	.clipped .border {
		position: absolute;
		z-index: 1;
		background: var(--main-color);
		height: 100%;
		width: 200%;
		top: 0;
		left: 0;
	}
	.clipped.one {
		transform: translateX(-24px);
	}
	.clipped.two {
		transform: translateX(-48px);
	}
	.clipped.three {
		transform: translateX(-72px);
	}
	.clipped.four {
		transform: translateX(-96px);
	}
	.glass {
		width: 50%;
		padding: 1rem 2rem;
		box-sizing: border-box;
		backdrop-filter: blur(24px);
		-webkit-backdrop-filter: blur(24px);
		text-align: center;
	}
	.glass :global(h3) {
		font-size: 1.4rem;
		margin-bottom: 1rem;
	}
	.inner {
		margin-left: -32px;
	}
	@media only screen and (max-width: 1440px) {
		.transactions {
			padding: 4em 2em;
		}
	}
	@media only screen and (max-width: 600px) {
		.transactions {
			padding: 1em 2em;
		}
	}
</style>
