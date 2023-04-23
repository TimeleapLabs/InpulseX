<script>
	import Title from './Title.svelte';
	import Paragraph from './Paragraph.svelte';
	import { fade } from 'svelte/transition';

	export let member;
	export let onSelect;
	export let index;

	let frame = 0;
	let bio = false;

	const animate = (e) => {
		e.preventDefault();
		if (!bio) {
			onSelect(index);
			bio = !bio;
			if (frame === 0) {
				frame = 1;
				setTimeout(() => (frame = 2), 1000);
			}
		} else {
			onSelect(null);
			frame = 0;
		}
	};
</script>

<a class="wrap" href="#animate" on:click={animate}>
	<div class="profile">
		{#if frame === 0}
			<img src="/images/members/{member.image}.jpg" alt={member.name} />
		{:else if frame > 0}
			<video src="/videos/x.mp4" muted autoplay />
		{/if}
		{#if frame === 2}
			<img
				src="/images/members/{member.image}.suite.jpg"
				alt={member.name}
				class="overlay"
				transition:fade={{ duration: 3000 }}
			/>
		{/if}
		<div class="name" class:solid={frame === 2}>
			<Title as="h4">{member.name}</Title>
		</div>
	</div>
	<div class="dots">
		{#each Array(9).fill() as _}
			<div class="dot" />
		{/each}
	</div>
	<div class="role">
		<img src="/images/members/{member.image}.jpg" alt={member.name} />
		<div class="text">
			<Title as="h5">{member.role}</Title>
		</div>
	</div>
</a>

{#if bio}
	<div class="bio" transition:fade>
		<Title as="h4">{member.name}</Title>
		<Title as="h5">{member.role}</Title>
		{#each member.bio as paragraph}
			<Paragraph>{paragraph}</Paragraph>
		{/each}
	</div>
{/if}

<style>
	a {
		text-align: center;
		text-decoration: none;
		color: #fff;
		display: flex;
		gap: 1em;
		flex-direction: column;
		align-items: center;
	}
	.profile {
		width: 200px;
		height: 200px;
		overflow: hidden;
		border-radius: 100px;
		box-shadow: 0px 0px 8px 4px var(--shadow-color);
		border: 2px solid var(--main-color);
		position: relative;
	}
	.profile .name {
		position: absolute;
		z-index: 1;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		opacity: 0.35;
		font-size: 0.8em;
		text-shadow: 0px 0px 4px rgba(0, 0, 0, 0.9), 0px 0px 4px rgba(0, 0, 0, 0.9);
	}
	.name.solid {
		transition: cubic-bezier(0.075, 0.82, 0.165, 1) 0.35s all;
		opacity: 0.9;
	}
	.profile .name :global(h4) {
		font-size: 4em;
	}
	video,
	img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	.overlay {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	.role {
		position: relative;
		border: 2px solid var(--main-color);
		border-radius: 8px;
		min-width: 80%;
		overflow: hidden;
	}
	.role img {
		width: 100%;
		height: 100%;
		object-fit: cover;
		position: absolute;
	}
	.role .text {
		width: 100%;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
		backdrop-filter: blur(32px);
		-webkit-backdrop-filter: blur(32px);
		padding: 0 1em;
		box-sizing: border-box;
	}
	.role .text :global(h5) {
		margin: 0.5em 0;
	}
	.dots {
		display: flex;
		gap: 0.5rem;
	}
	.dot {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: var(--main-color);
	}
	@media only screen and (min-width: 600px) {
		.bio {
			display: none;
		}
	}
</style>
