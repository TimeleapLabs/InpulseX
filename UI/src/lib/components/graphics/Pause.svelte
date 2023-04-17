<script>
	export let color = '#fff';
	export let width = '32px';
</script>

<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" style="--size: {width};">
	<g id="pause" fill={color}>
		<rect height="28" rx="1" width="7" x="7" y="2" />
		<rect height="28" rx="1" width="7" x="18" y="2" />
	</g>
</svg>

<style>
	svg {
		width: var(--size);
		height: var(--size);
	}
</style>
