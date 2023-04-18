<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import { fade } from 'svelte/transition';

	const members = [
		{
			name: 'JAY',
			role: 'Founder & CEO',
			color: '#DC15A4',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
			bio: [
				'Jay, the founder and CEO, is a serial entrepreneur with 18 years of experience in marketing, technology and international business management. He co-founded an app company in 2013 in London, where he worked for more than three years. He also founded a venture to build the first immersive dome Park in London with partners in USA and Russia; the business, unfortunately, suffered an unexpected impact due to the Pandemic putting on hold the whole entertainment industry across the globe. Since 2017, Jay has been running a multimillion-dollar crypto fund, specialising in early-stage projects.',
				'His passion for crypto, art, technology and ultimately the mysteries of the universe was the catalyst that inspired him to found InpulseX.'
			]
		},
		{
			name: 'ROD',
			role: 'Operations Director',
			color: '#FFFFFF',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
			bio: ['Lorem ipsum', '']
		},
		{
			name: 'RAFAEL',
			role: 'Graphic Design Manager',
			color: '#2B7BF3',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		},
		{
			name: 'ROD',
			role: 'Operations Director',
			color: '#FFFFFF',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		},
		{
			name: 'JAY',
			role: 'Founder & CEO',
			color: '#DC15A4',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
			bio: [
				'Jay, the founder and CEO, is a serial entrepreneur with 18 years of experience in marketing, technology and international business management. He co-founded an app company in 2013 in London, where he worked for more than three years. He also founded a venture to build the first immersive dome Park in London with partners in USA and Russia; the business, unfortunately, suffered an unexpected impact due to the Pandemic putting on hold the whole entertainment industry across the globe. Since 2017, Jay has been running a multimillion-dollar crypto fund, specialising in early-stage projects.',
				'His passion for crypto, art, technology and ultimately the mysteries of the universe was the catalyst that inspired him to found InpulseX.'
			]
		},
		{
			name: 'ROD',
			role: 'Operations Director',
			color: '#FFFFFF',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
			bio: ['Lorem ipsum', '']
		},
		{
			name: 'RAFAEL',
			role: 'Graphic Design Manager',
			color: '#2B7BF3',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		},
		{
			name: 'ROD',
			role: 'Operations Director',
			color: '#FFFFFF',
			image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		}
	];

	let currentIndex = 0;
	let transition = false;

	const onMouseEnter = (index) => (_e) => {
		if (currentIndex != parseInt(index)) {
			transition = true;
			setTimeout(() => {
				currentIndex = parseInt(index);
				transition = false;
			}, 400);
		}
	};
</script>

<div class="team">
	<div class="content">
		<img class="title" src="/images/team.svg" alt="The InpulseX Team" />
		{#if !transition}
			<div class="bio" transition:fade>
				<Title as="h4">{members[currentIndex].name}</Title>
				<Title as="h5">{members[currentIndex].role}</Title>
				{#each members[currentIndex].bio as paragraph}
					<Paragraph>{paragraph}</Paragraph>
				{/each}
			</div>
		{/if}
	</div>
	<div class="grid">
		{#each Object.entries(members) as [index, member]}
			<div
				on:mouseenter={onMouseEnter(index)}
				class="member"
				style="--main-color: {member.color}; --shadow-color: {member.color}66;"
			>
				<div class="profile">
					<img src={member.image} alt={member.name} />
					<div class="name">
						<Title as="h4">{member.name}</Title>
					</div>
				</div>
				<div class="dots">
					{#each Array(9).fill() as _}
						<div class="dot" />
					{/each}
				</div>
				<div class="role">
					<img src={member.image} alt={member.name} />
					<div class="text">
						<Title as="h5">{member.role}</Title>
					</div>
				</div>
			</div>
		{/each}
	</div>
</div>

<style>
	img.title {
		max-width: 70%;
	}
	.team {
		display: grid;
		grid-template-columns: 2fr 4fr;
		padding: 4em 20em;
		gap: 8rem;
		position: relative;
		box-sizing: border-box;
		background-color: #140f29;
	}
	.grid {
		display: grid;
		gap: 2rem;
		grid-template-columns: 1fr 1fr 1fr;
	}
	.member {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 1em;
	}
	.member .profile {
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
		opacity: 0.9;
	}
	.profile .name :global(h4) {
		font-size: 4em;
	}
	.member img {
		width: 100%;
		height: 100%;
		object-fit: cover;
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
	.bio {
		margin-top: 2em;
	}
	.bio :global(p + p) {
		margin-top: 1em;
	}
</style>
