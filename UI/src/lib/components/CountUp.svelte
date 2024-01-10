<script>
	import { onMount } from 'svelte';

	export let value;
	export let steps = 100;

	const frames = new Array(steps).fill().map((_, i) => Math.floor((value * i) / steps));

	let frame = 0;
	let display = 0;
	let interval;

	const count = () => {
		if (frame === steps - 1) {
			clearInterval(interval);
			display = value;
			return;
		}
		display = frames[++frame];
	};

	onMount(() => {
		interval = setInterval(count, 15);
		return () => clearInterval(interval);
	});
</script>

{display}
