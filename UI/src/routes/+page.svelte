<script>
	import Hero from '../lib/components/home/Hero.svelte';
	import About from '../lib/components/home/About.svelte';
	import Navbar from '../lib/components/Navbar.svelte';
	import Utilities from '../lib/components/home/Utilities.svelte';
	import Game from '../lib/components/home/Game.svelte';
	import Characters from '../lib/components/home/Characters.svelte';
	import Team from '../lib/components/home/Team.svelte';
	import Charts from '../lib/components/home/Charts.svelte';
	import Phases from '../lib/components/home/Phases.svelte';
	import Partners from '../lib/components/home/Partners.svelte';
	import Certificates from '../lib/components/home/Certificates.svelte';
	import Highlight from '../lib/components/home/Highlight.svelte';
	import Subscribe from '../lib/components/home/Subscribe.svelte';
	import Footer from '../lib/components/home/Footer.svelte';

	import { Toaster } from 'svelte-french-toast';
</script>

<Navbar />
<Hero />
<About />
<Utilities />
<Game />
<Characters />
<Team />
<Charts />
<Phases />
<Partners />
<Certificates />
<Highlight />
<Subscribe />
<Footer />

<Toaster />
