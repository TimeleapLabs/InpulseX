<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import Member from '../Member.svelte';
	import { fade } from 'svelte/transition';
	import { onMount } from 'svelte';
	import { getImagePath, getMembers } from '../../api';

	let members = [];

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

	onMount(async () => {
		const membersData = await getMembers();
		members = membersData.map((member) => ({
			...member,
			portrait: getImagePath(member.portrait),
			image: getImagePath(member.image)
		}));
	});
</script>

<div class="team" id="team">
	<div class="content">
		<div class="sticky">
			<img class="title" src="/images/team.svg" alt="The InpulseX Team" />
			{#if members[currentIndex] && !transition}
				<div class="bio" transition:fade>
					<Title as="h4">{members[currentIndex].name}</Title>
					<Title as="h5">{members[currentIndex].role}</Title>
					<Paragraph class="member-title">{members[currentIndex].title}</Paragraph>
					<Paragraph>{@html members[currentIndex].description}</Paragraph>
				</div>
			{/if}
		</div>
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
	.sticky {
		position: sticky;
		top: 8em;
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

	.bio :global(.member-title) {
		font-weight: bold;
	}
	@media only screen and (max-width: 1700px) {
		.team {
			padding: 4em;
			grid-template-columns: 1fr 3fr;
		}
		.grid {
			grid-template-columns: 1fr 1fr 1fr;
		}
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
	.bio :global(h4) {
		font-size: 1.5em;
	}
	.bio :global(h5) {
		font-weight: bold;
		font-family: 'Groningen';
	}
	.bio :global(b) {
		font-weight: bold;
		font-family: 'Groningen';
	}
</style>
