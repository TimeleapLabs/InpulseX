<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import ArrowRightLong from '../icons/ArrowRightLong.svelte';

	export let title;
	export let body;
	export let href;
</script>

<a class="card" {href}>
	<div class="card-inner">
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
	</div>
</a>

<style>
	.card {
		background: linear-gradient(
			var(--gradient-rotate, 246deg),
			var(--primary-pink) 7.97%,
			var(--primary-blue) 49.17%,
			var(--secondary-blue) 92.1%
		);
		padding: 1px;
		box-sizing: border-box;
		text-decoration: none;
		color: currentColor;
		border-radius: 8px;
		position: relative;
		z-index: 20;
	}
	.card:before {
		content: '';
		background-color: var(--secondary-blue);
		box-shadow: 0 0 120px 70px var(--secondary-blue-transparent);
		position: absolute;
		z-index: 0;
		left: 10%;
		top: 30%;
	}
	.card:after {
		content: '';
		background-color: var(--primary-pink);
		box-shadow: 0 0 120px 70px var(--primary-pink-transparent);
		position: absolute;
		z-index: 0;
		right: 10%;
		bottom: 30%;
	}
	.card-inner {
		background: rgb(60, 114, 220);
		padding: 0;
		transition: cubic-bezier(0.25, 0.46, 0.45, 0.94) all 0.4s;
		background-size: 200% 100%;
		box-sizing: border-box;
		border-radius: 8px;
		z-index: 20;
		position: relative;
	}
	.card:hover {
		background-position: 50%;
	}
	.content {
		padding: 1em;
		background: rgb(73, 128, 223);
		background-image: linear-gradient(90deg, rgba(73, 128, 223, 1) 10%, rgba(50, 94, 181, 1) 50%);
		position: relative;
		transition: cubic-bezier(0.25, 0.46, 0.45, 0.94) all 0.4s;
		background-size: 200% 100%;
		height: 100%;
		box-sizing: border-box;
		border-radius: 8px;
		z-index: 20;
		position: relative;
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
