<script>
	import Title from '../Title.svelte';
	import Download from '../icons/Download.svelte';
</script>

<div class="certificates" id="certificates">
	<div class="ripple pink" />
	<Title as="h2" class="title" centered>Certificates</Title>
	<div class="grid">
		<a
			href="/audits/SmartContract_Audit_Solidproof_InpulseXToken.pdf"
			target="_blank"
			class="certificate"
		>
			<img src="/images/token.png" alt="Token Audit" />
			<span><Download width="1em" height="1em" /> Token Audit</span>
		</a>
		<a
			href="/audits/SmartContract_Audit_Solidproof_InpulseXSwap.pdf"
			target="_blank"
			class="certificate"
		>
			<img src="/images/swap.png" alt="Bridge Audit" />
			<span><Download width="1em" height="1em" /> Bridge Audit</span>
		</a>
		<a
			href="/audits/SmartContract_Audit_Solidproof_InpulseXStaking.pdf"
			target="_blank"
			class="certificate"
		>
			<img src="/images/staking.png" alt="Staking Audit" />
			<span><Download width="1em" height="1em" /> Staking Audit</span>
		</a>
	</div>
</div>

<style>
	.certificates {
		position: relative;
		padding: 12em;
		background-color: #140f29;
		overflow: hidden;
	}
	.ripple.pink {
		background: url(/images/ripple.pink.png) no-repeat center;
		background-size: contain;
		position: absolute;
		width: 100%;
		height: 100%;
		left: 0;
		top: 0;
		z-index: 0;
	}
	.certificates :global(.title) {
		font-size: 4em;
		margin-bottom: 1em;
		z-index: 2;
		position: relative;
	}
	.certificate {
		box-shadow: 0px 0px 24px 8px rgba(0, 0, 0, 0.1);
		box-sizing: border-box;
		text-decoration: none;
		display: flex;
		position: relative;
		flex-direction: column;
		width: 300px;
		max-width: 80%;
		align-items: center;
	}
	.certificate span {
		color: #000;
		background: rgba(255, 255, 255, 0.7);
		padding: 1em 2em;
		border-top-right-radius: 0;
		border-top-left-radius: 0;
		position: absolute;
		width: 100%;
		display: block;
		box-sizing: border-box;
		bottom: 0;
		display: flex;
		align-items: center;
		gap: 1em;
		backdrop-filter: blur(32px);
		-webkit-backdrop-filter: blur(32px);
	}
	.certificate img {
		width: 100%;
		object-fit: cover;
	}
	.certificate {
		clip-path: polygon(
			0 40px,
			40px 0,
			100% 0,
			100% calc(100% - 40px),
			calc(100% - 40px) 100%,
			0 100%
		);
		position: relative;
		overflow: hidden;
	}
	.certificate:before {
		content: '';
		position: absolute;
		z-index: 1;
		inset: 0;
		background: rgb(43, 123, 243);
		background: linear-gradient(167deg, rgba(43, 123, 243, 1) 30%, rgba(220, 21, 164, 1) 100%);
		clip-path: polygon(
			0 40px,
			40px 0,
			100% 0,
			100% calc(100% - 40px),
			calc(100% - 40px) 100%,
			0 100%,
			0 40px,
			4px calc(40px + 1.66px),
			4px calc(100% - 4px),
			calc(100% - 40px - 1.66px) calc(100% - 4px),
			calc(100% - 4px) calc(100% - 40px - 1.66px),
			calc(100% - 4px) 4px,
			calc(40px + 1.66px) 4px,
			4px calc(40px + 1.66px)
		);
	}
	.grid {
		display: flex;
		flex-wrap: wrap;
		gap: 2em;
		align-items: center;
		justify-content: center;
	}
	@media only screen and (max-width: 600px) {
		.certificates {
			padding: 1em 2em;
		}
	}
	@media only screen and (max-width: 1440px) {
		.certificates {
			padding: 4em;
		}
	}
	@media only screen and (max-width: 960px) {
		.certificates {
			padding: 2em;
		}
	}
</style>
