<script>
	import LinkTree from '../icons/LinkTree.svelte';
</script>

<div class="footer">
	<div class="ripple" />
	<div class="linktree">
		<a href="https://linktr.ee/inpulsex_official" rel="noreferrer" target="_blank">
			<LinkTree />
		</a>
	</div>
	<div class="spacer" />
	<address>
		InpulseX UK <br />
		Buckingham Palace Road <br />
		London, United Kingdom
	</address>
	<address>
		InpulseX FZCO <br />
		DSO - IFZA <br />
		Digital Park, Silicon Oasis <br />
		Dubai, UAE
	</address>
</div>

<style>
	.footer {
		position: relative;
		padding: 2em 12em;
		background-color: #1c163e;
		overflow: hidden;
		display: flex;
		gap: 4em;
		flex-wrap: wrap;
	}
	.spacer {
		flex: 1;
	}
	address,
	div {
		position: relative;
		z-index: 1;
	}
	.ripple {
		position: absolute;
		width: 100%;
		height: 100%;
		background-image: url(/images/ripple.pink.png);
		background-repeat: no-repeat;
		background-size: 100%;
		background-position: center;
		left: 0;
		top: 0;
		opacity: 0.2;
		z-index: 0;
	}
	@media only screen and (max-width: 600px) {
		.footer {
			padding: 1em 2em;
		}
	}
</style>
