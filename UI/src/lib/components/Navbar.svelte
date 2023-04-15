<script>
	import Button from './Button.svelte';
</script>

<div class="navbar">
	<img src="/images/logo.webp" alt="InpulseX logo" />
	<div class="spacer" />
	<a href="#">Beginning</a>
	<a href="#">Utilities</a>
	<a href="#">About</a>
	<a href="#">Team</a>
	<a href="#">Tokenomics</a>
	<a href="#">SpaceMap</a>
	<a href="#">Litepaper</a>
	<Button href="">Buy now</Button>
</div>

<style>
	.navbar {
		display: flex;
		gap: 2em;
		position: fixed;
		top: 0;
		z-index: 100;
		background: rgba(0, 0, 0, 0.4);
		backdrop-filter: blur(16px);
		align-items: center;
		width: 100%;
		padding: 1em 4em;
		box-sizing: border-box;
	}
	a {
		color: #fff;
		text-decoration: none;
	}
	a:hover {
		transition: cubic-bezier(0.23, 1, 0.32, 1) all 0.4s;
		color: var(--primary-pink);
	}
	.spacer {
		flex: 1;
	}
	img {
		height: 2em;
	}
</style>
