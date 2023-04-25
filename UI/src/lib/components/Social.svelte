<script>
	import Facebook from './icons/Facebook.svelte';
	import Telegram from './icons/Telegram.svelte';
	import Twitter from './icons/Twitter.svelte';
	import Discord from './icons/Discord.svelte';
</script>

<div class="socials">
	<a target="_blank" rel="noreferrer" href="https://t.me/InpulseX_Official">
		<Telegram />
	</a>
	<a target="_blank" rel="noreferrer" href="https://twitter.com/InpulseX_io">
		<Twitter />
	</a>
	<a target="_blank" rel="noreferrer" href="https://discord.gg/kH6PaHsNHK">
		<Discord />
	</a>
	<a target="_blank" rel="noreferrer" href="https://www.facebook.com/InpulseX/">
		<Facebook />
	</a>
</div>

<style>
	.socials {
		position: absolute;
		right: 0;
		top: 50%;
		transform: translateY(-50%);
		backdrop-filter: blur(32px);
		-webkit-backdrop-filter: blur(32px);
		border-top-left-radius: 2em;
		border-bottom-left-radius: 2em;
		display: flex;
		flex-direction: column;
		padding: 1em;
		gap: 1em;
		padding-right: 0.75em;
	}
	a {
		text-decoration: none;
		transition: cubic-bezier(0.55, 0.055, 0.675, 0.19) 0.1s all;
		color: #fff;
	}
	a:hover {
		transform: scale(1.1);
	}
</style>
