<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import Member from '../Member.svelte';
	import { fade } from 'svelte/transition';

	const members = [
		{
			name: 'JAY',
			role: 'Founder & CEO',
			color: '#DC15A4',
			image: 'rod',
			bio: [
				'Jay, the founder and CEO, is a serial entrepreneur with 18 years of experience in marketing, technology and international business management. He co-founded an app company in 2013 in London, where he worked for more than three years. He also founded a venture to build the first immersive dome Park in London with partners in USA and Russia; the business, unfortunately, suffered an unexpected impact due to the Pandemic putting on hold the whole entertainment industry across the globe. Since 2017, Jay has been running a multimillion-dollar crypto fund, specialising in early-stage projects.',
				'His passion for crypto, art, technology and ultimately the mysteries of the universe was the catalyst that inspired him to found InpulseX.'
			]
		}
		// {
		// 	name: 'ROD',
		// 	role: 'Operations Director',
		// 	color: '#FFFFFF',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
		// 	bio: ['Lorem ipsum', '']
		// },
		// {
		// 	name: 'RAFAEL',
		// 	role: 'Graphic Design Manager',
		// 	color: '#2B7BF3',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		// },
		// {
		// 	name: 'ROD',
		// 	role: 'Operations Director',
		// 	color: '#FFFFFF',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		// },
		// {
		// 	name: 'JAY',
		// 	role: 'Founder & CEO',
		// 	color: '#DC15A4',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
		// 	bio: [
		// 		'Jay, the founder and CEO, is a serial entrepreneur with 18 years of experience in marketing, technology and international business management. He co-founded an app company in 2013 in London, where he worked for more than three years. He also founded a venture to build the first immersive dome Park in London with partners in USA and Russia; the business, unfortunately, suffered an unexpected impact due to the Pandemic putting on hold the whole entertainment industry across the globe. Since 2017, Jay has been running a multimillion-dollar crypto fund, specialising in early-stage projects.',
		// 		'His passion for crypto, art, technology and ultimately the mysteries of the universe was the catalyst that inspired him to found InpulseX.'
		// 	]
		// },
		// {
		// 	name: 'ROD',
		// 	role: 'Operations Director',
		// 	color: '#FFFFFF',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg',
		// 	bio: ['Lorem ipsum', '']
		// },
		// {
		// 	name: 'RAFAEL',
		// 	role: 'Graphic Design Manager',
		// 	color: '#2B7BF3',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		// },
		// {
		// 	name: 'ROD',
		// 	role: 'Operations Director',
		// 	color: '#FFFFFF',
		// 	image: 'https://inpulsex.io/wp-content/uploads/2022/01/Rod.jpg'
		// }
	];

	let currentIndex;
	let transition = false;

	const onSelect = (index) => {
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
		{#if typeof currentIndex === 'number' && !transition}
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
			<div class="member" style="--main-color: {member.color}; --shadow-color: {member.color}66;">
				<Member {member} {onSelect} {index} />
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
	.bio {
		margin-top: 2em;
	}
	.bio :global(p + p) {
		margin-top: 1em;
	}
	@media only screen and (max-width: 1240px) {
		.team {
			padding: 4em;
			grid-template-columns: 1fr 2fr;
		}
		.grid {
			grid-template-columns: 1fr 1fr;
		}
	}
	@media only screen and (max-width: 600px) {
		.team {
			padding: 1em 2em;
			grid-template-columns: 1fr;
		}
		.grid {
			grid-template-columns: 1fr;
		}
		.bio {
			display: none;
		}
	}
</style>
