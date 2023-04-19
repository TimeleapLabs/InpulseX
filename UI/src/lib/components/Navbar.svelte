<script>
	import Button from './Button.svelte';
	import Burger from './icons/Burger.svelte';
	import X from './icons/X.svelte';
	import { fly } from 'svelte/transition';
	import { clickOutside } from '../clickOutside';

	let open = false;
</script>

<div class="wrap" use:clickOutside={() => (open = false)}>
	<div class="navbar">
		<a href="#menu" on:click={() => (open = true)}>
			<Burger />
		</a>
		<div class="logo">
			<img src="/images/logo.webp" alt="InpulseX logo" />
		</div>
		<div class="buttons">
			<Button href="">Buy now</Button>
		</div>
	</div>

	{#if open}
		<div class="sidebar" transition:fly={{ x: -200, duration: 200 }}>
			<a href="#menu" on:click={() => (open = false)}>
				<X />
			</a>
			<a href="#">Beginning</a>
			<a href="#">Utilities</a>
			<a href="#">About</a>
			<a href="#">Team</a>
			<a href="#">Tokenomics</a>
			<a href="#">SpaceMap</a>
			<a href="#">Litepaper</a>
		</div>
	{/if}
</div>

<style>
	.navbar {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
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
	.logo {
		text-align: center;
	}
	.buttons {
		text-align: right;
	}
	.sidebar {
		position: fixed;
		left: 0;
		top: 0;
		z-index: 100;
		width: 320px;
		height: 100%;
		background: rgba(0, 0, 0, 0.4);
		backdrop-filter: blur(16px);
		box-sizing: border-box;
		padding: 4em;
		display: flex;
		gap: 2em;
		flex-direction: column;
		padding-top: 1.5em;
	}
	a {
		color: #fff;
		text-decoration: none;
	}
	a:hover {
		transition: cubic-bezier(0.23, 1, 0.32, 1) all 0.4s;
		color: var(--primary-pink);
	}
	img {
		height: 2em;
	}
	@media only screen and (max-width: 600px) {
		.navbar {
			padding: 0.5em 1em;
			grid-template-columns: 1fr 1fr 6fr;
		}
		.sidebar {
			padding: 1em 2em;
		}
		img {
			height: 1.2em;
		}
	}
</style>
