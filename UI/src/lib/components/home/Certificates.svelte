<script>
	import Title from '../Title.svelte';
</script>

<div class="certificates">
	<div class="ripple pink" />
	<Title as="h2" class="title" centered>Certificates</Title>
	<div class="grid">
		<a
			href="/audits/SmartContract_Audit_Solidproof_InpulseXToken.pdf"
			target="_blank"
			class="certificate"
		>
			<img src="/images/token.png" alt="Token Audit" />
			<span>Token Audit</span>
		</a>
		<a
			href="/audits/SmartContract_Audit_Solidproof_InpulseXSwap.pdf"
			target="_blank"
			class="certificate"
		>
			<img src="/images/swap.png" alt="Bridge Audit" />
			<span>Bridge Audit</span>
		</a>
		<a
			href="/audits/SmartContract_Audit_Solidproof_InpulseXStaking.pdf"
			target="_blank"
			class="certificate"
		>
			<img src="/images/staking.png" alt="Staking Audit" />
			<span>Staking Audit</span>
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
		background: var(--primary-blue);
		border-radius: 1em;
		box-shadow: 0px 0px 24px 8px rgba(0, 0, 0, 0.1);
		padding: 0.5em;
		box-sizing: border-box;
		text-decoration: none;
		display: flex;
		position: relative;
		flex-direction: column;
		width: 300px;
		max-width: 80%;
		align-items: center;
		padding-bottom: 3em;
	}
	.certificate span {
		background: #fff;
		border-radius: 1em;
		padding: 1em 2em;
		border-top-right-radius: 0;
		border-top-left-radius: 0;
		color: #000;
		position: absolute;
		width: calc(95% - 1em);
		display: block;
		box-sizing: border-box;
		bottom: 1em;
	}
	.certificate img {
		border-radius: 1em;
		width: 95%;
		object-fit: contain;
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
