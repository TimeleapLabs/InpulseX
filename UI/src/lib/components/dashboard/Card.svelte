<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import ArrowRightLong from '../icons/ArrowRightLong.svelte';

	export let title;
	export let body;
	export let href;
</script>

<a class="card" {href}>
	<div class="content">
		<Title as="h4">{title}</Title>
		<Paragraph>
			{body}
			<div class="arrow">
				<ArrowRightLong height={'1em'} width={'1em'} />
			</div>
		</Paragraph>
		<div class="slot">
			<slot />
		</div>
	</div>
</a>

<style>
	.card {
		background: rgb(60, 114, 220);
		background-image: linear-gradient(90deg, rgba(60, 114, 220, 1) 10%, rgba(24, 60, 131, 1) 50%);
		padding: 0.3rem;
		text-decoration: none;
		color: currentColor;
		transition: cubic-bezier(0.25, 0.46, 0.45, 0.94) all 0.4s;
		background-size: 200% 100%;
	}
	.card:hover {
		background-position: 50%;
	}
	.content {
		padding: 1em;
		background: rgb(73, 128, 223);
		background-image: linear-gradient(90deg, rgba(73, 128, 223, 1) 10%, rgba(50, 94, 181, 1) 50%);
		box-shadow: inset 0px 0px 8px 1px rgba(255, 255, 255, 0.3);
		position: relative;
		transition: cubic-bezier(0.25, 0.46, 0.45, 0.94) all 0.4s;
		background-size: 200% 100%;
	}
	.card:hover .content {
		background-position: 50%;
	}
	.content :global(h4) {
		font-size: 1.4em;
		margin-bottom: 0.7em;
	}
	.arrow {
		display: inline;
		margin-left: 0.25rem;
		transition: cubic-bezier(0.25, 0.46, 0.45, 0.94) all 0.4s;
	}
	.arrow :global(svg) {
		margin-bottom: -4px;
	}
	.card:hover .arrow {
		margin-left: 1rem;
	}
</style>
