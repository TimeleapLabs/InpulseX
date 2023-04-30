<script>
	import Title from '../Title.svelte';
	import Paragraph from '../Paragraph.svelte';
	import Member from '../Member.svelte';
	import { fade } from 'svelte/transition';

	const members = [
		{
			name: 'Jay',
			role: 'Founder & CEO',
			color: '#2B7BF3',
			image: 'jay',
			bio: [
				'<b>The Mastermind Behind InpulseX</b>',
				'Introducing Jay The Creator. With 18 years of experience in marketing, technology, and international business management, Jay is a seasoned serial entrepreneur with a proven track record of success. He co-founded an app company in London in 2013 and later founded a venture aimed at building the first immersive dome park in London, partnering with established companies in the USA & Russia.',
				'Currently, Jay runs a marketing company in Dubai, leveraging his expertise to help businesses achieve success in the digital age. But his passion for crypto, art, technology, and the mysteries of the universe inspired him to create InpulseX.',
				"Jay used to manage a multimillion-dollar crypto fund, especializing in early-stage projects from 2017 to 2022. With his vast knowledge and experience in the industry, Jay is the perfect leader to spearhead InpulseX's mission. He embodies the core values of the company - creativity, innovation, and passion, and his unparalleled expertise and strategic thinking make him the driving force behind InpulseX's success.",
				'Join InpulseX to have access to an experienced and visionary leader committed to taking the company to new heights.'
			]
		},
		{
			name: 'ROD',
			role: 'Operations Director',
			color: '#DC15A4',
			image: 'rod',
			bio: [
				'<b>The Pinnacle of Delivery Excellence</b>',
				'In collaboration with Jay, Rod is the driving force behind successful deliveries, boasting an impressive 24-year track record in the technology sector. He has worked with renowned global corporations such as EDS, HP, Accenture, Telefonica, Unilever, Virgin Active, Costa Coffee and Maersk.',
				'Rod\'s expertise lies in leading highly competent teams and executing complex international mergers and acquisitions projects. He possesses a remarkable aptitude for breaking down the "big picture" into manageable components, ensuring effective and efficient delivery at every stage.',
				'Rod is an ardent crypto enthusiast and manages a crypto investment fund in the UK, specialising in algorithmic and leverage trading.',
				''
			]
		},
		{
			name: 'Freddie',
			role: 'BD Director',
			color: '#FFFFFF',
			image: 'freddie',
			bio: [
				'<b>The Master of Deal-Making</b>',
				"With over 18 years in the luxury market, Freddie has successfully established one of Europe's largest private jet companies. His exceptional sales abilities and natural talent for closing deals have enabled him to forge an extensive network of the world's most affluent individuals, many of whom now consider Freddie, a close friend.",
				'Freddie plays a pivotal role in the InpulseX Core Team, poised to leverage his top-tier connections, including crypto entrepreneurs, elite investors, and celebrities, to bolster the project and the Mars Mission.',
				'Although a seasoned professional, Freddie is a true crypto pioneer, having been an early adopter since 2010. His wealth of knowledge in the crypto sphere is genuinely remarkable and invaluable to any endeavour.',
				''
			]
		},
		{
			name: 'Scott',
			role: 'Marketing Director',
			color: '#FFFFFF',
			image: 'scott',
			bio: [
				'<b>The Maestro of Networking</b>',
				'Scott, a seasoned marketing expert and exceptional leader, boasts more than 18 years of experience in promoting, constructing, and directing multi-disciplinary teams. He excels in expanding and marketing companies, particularly within the investment and aviation sectors.',
				"Scott's extensive expertise encompasses intricate client organisations, cultivating and guiding top-performing teams, and specialising in expediting transformation for institutions and organisations. His proficiency in marketing and networking makes him a formidable force in his field.",
				'',
				''
			]
		},
		{
			name: 'Darryl',
			role: 'Creative Director',
			color: '#2B7BF3',
			image: 'darryl',
			bio: [
				'<b>The Visionary Lens Master</b>',
				"Darryl's innate grasp of rhythm, movement, and on-screen chemistry has culminated in a distinct and captivating stylistic approach. His professional filmmaking career has taken him to over 30 countries worldwide, working with various models, actors, agencies, artists, and companies across numerous campaigns.",
				'He has collaborated with prestigious brands such as Netflix, Virgin Media, Norwegian Cruise Line, Red Bull Studios, I-D magazine, and VICE. Recently, Darryl has written and directed a collection of short films based in Los Angeles and is currently producing his feature film debut.',
				'Darryl is thrilled and honoured to contribute his exceptional talents to the InpulseX team as they embark on their interplanetary odyssey.',
				''
			]
		},
		{
			name: 'Rafael',
			role: 'Brand Identity Manager',
			color: '#DC15A4',
			image: 'rafael',
			bio: [
				'<b>The Swift and Skilled Virtuoso</b>',
				'Armed with a degree in Graphic Design & Marketing and 15 years of experience, this accomplished artist has collaborated with top agencies from diverse industries in numerous countries throughout South America and Europe.',
				'Reminiscing about childhood days spent watching Star Trek and dreaming of interplanetary travels, this creative genius is eager to join the InpulseX journey, exclaiming, "Beam me up, InpulseX!"',
				'',
				''
			]
		},
		{
			name: 'Anna',
			role: 'NFT Artistic Director',
			color: '#DC15A4',
			image: 'anna',
			bio: [
				'<b>The Connoisseur of Artistic Brilliance</b>',
				'Before dedicating her ingenuity and expertise to InpulseX NFT Collections, Anna thrived in the cutting-edge sphere of experiential marketing. She delved into and integrated advanced digital immersive and interactive experiences into live events, brand activations, and corporate ventures. Along the way, she encountered many progressive, multi-talented artists, some of whom will soon be represented with pride by InpulseX.',
				"Anna's uplifting attitude and vibrant energy inspire everyone around her to strive for excellence and success.",
				'',
				''
			]
		},
		{
			name: 'Lisa Marie',
			role: 'Partnerships Manager',
			color: '#FFFFFF',
			image: 'lisa',
			bio: [
				'<b>The Sorceress</b>',
				'Having accumulated years of administrative and moderating experience in the Crypto industry, I have successfully established solid relationships with significant players in the community. My exceptional communication skills enable me to form strategic partnerships for InpulseX, based on shared business objectives. As a natural relationship-builder, I have continuously fostered prosperous partnerships.',
				"In my role as a Partnership Manager at InpulseX, obtaining and nourishing these partnerships is crucial in driving growth and expanding our company's reach. My deep passion for InpulseX's mission has fuelled my eagerness to work alongside like-minded individuals and organizations, with the aim of achieving our shared objectives.",
				'',
				''
			]
		},
		{
			name: 'Patrick',
			role: 'Relations Manager',
			color: '#2B7BF3',
			image: 'patrick',
			bio: [
				'<b>Crypto Community Architect</b>',
				'Patrick is a seasoned crypto aficionado acquiring years of administrative and moderating experience. He has nurtured a growing network and developed a passion for forging lasting relationships with fellow crypto enthusiasts and professionals alike and continues to work with various crypto organizations, amassing a wealth of experience and unique insights into this rapidly evolving industry.',
				'',
				'',
				''
			]
		},
		{
			name: 'Glasson',
			role: 'Business Development',
			color: '#FFFFFF',
			image: 'inia',
			bio: [
				'<b>The Deal Specialist</b>',
				'Well known in the crypto space, CryptoGlasson has spent the past six years exploring the depths and crevices of this industry, emerging as a reputable strategic deal maker. Having built strong relationships with the crème de la crème of the VC world and closely associated with numerous emerging personalities and projects, Glasson is instrumental in ensuring that InpulseX creates elite partnerships. ',
				'With an ever-growing wealth of knowledge and understanding of blockchain technology, Glasson is committed to shaping InpulseX into the giant it deserves to be.',
				"Glasson's strongest attribute is their ability to get the job done, leaving nothing to chance.",
				''
			]
		},
		{
			name: 'Muza',
			role: 'Unreal Engine Developer',
			color: '#2B7BF3',
			image: 'muzammil',
			bio: [
				'<b>The 3D Expert</b>',
				'As a 3D artist, my area of expertise lies in Unreal Engine 5, where I specialize in character modeling, animation, and environment design, etc. I possess the skill to create exceptional 3D models and animations that cater to video games, product visualization projects, and short films. Over the years, I have accumulated vast experience, and with this, I am dedicated to bringing the InpulseX vision to life with mesmerizing 3D models, breathtaking environments, and much more.',
				'',
				'',
				''
			]
		},
		{
			name: 'Pouya',
			role: 'Head of Development',
			color: '#DC15A4',
			image: 'pouya',
			bio: [
				'<b>Cross-Domain Tech Prodigy</b>',
				"As CEO and Founder of Kenshi, I spearhead a team creating an innovative all-in-one platform for blockchain development. Our focus on cutting-edge technology and user experience propels us to push the limits of what's possible in the blockchain world.",
				"As CTO of Equip, I oversee the development of custom electronics, firmware, backends, and mobile apps. With vast software development experience and a passion for innovation, I'm excited to be part of such an exciting project.",
				"At InpulseX, I'm responsible for developing their website, staking dashboard, and smart contracts. It's an honor to work with a talented team on a project with the potential to revolutionize the crypto world, providing support for the Mars mission.",
				"Driven by a passion for decentralized computing, I invented my own distributed programming language. My involvement in the blockchain industry is driven by this fascination, and I'm thrilled to continue pushing the boundaries of what's possible. With 15+ years of software development experience and a proven record of running successful businesses, I bring knowledge and expertise to every project I undertake."
			]
		},
		{
			name: 'Michael',
			role: 'Legal Advisor',
			color: '#2B7BF3',
			image: 'michael',
			bio: [
				'<b>The Unbounded Finance Aficionado</b>',
				'Focused on imparting the wisdom gleaned from building companies and investing, striving to help others achieve predictable growth in their businesses and wealth. With a professional foundation in international financial optimisation, an area termed residency arbitrage, this expert provides consultation to companies seeking enhanced financial efficiency, security, and adaptability by leveraging global variations in law, pricing, and infrastructure.',
				'',
				'',
				''
			]
		},
		{
			name: 'NiKita',
			role: 'Gaming Advisor',
			color: '#FFFFFF',
			image: 'nikita',
			bio: [
				'<b>The Founder of Exverse.io</b>',
				'An esteemed figure in the web3 space, has a wealth of experience as a global marketing and business development director. With a proven track record of success, they have established themselves as a highly skilled and knowledgeable professional in the field. Their contributions to the development of web3 technologies have been widely recognised and have earned them a reputation as an innovator and leader in the industry.',
				'',
				'',
				''
			]
		},
		{
			name: 'Ryan',
			role: 'Global Advisor',
			color: '#DC15A4',
			image: 'ryan',
			bio: [
				'<b>Trailblazer in Web3 & Sports</b>',
				'Ryan Horn is a renowned business leader with over 25 years of experience across the dynamic fields of sports, fashion, entertainment, brands, web3 and gaming. His extensive experience spans building world-class businesses in various sectors.',
				'Ryan held a significant position in sports, NFTs, and fan tokens at Binance, a top global cryptocurrency platform. Presently, he co-founded N3ON, an innovative platform focused on IP - Web3 - Blockchain - Fintech - Loyalty - Payments & Funding. Alongside his involvement with N3ON, Ryan is advising for multiple projects such as InpulseX, showcasing his dedication to nurturing progress and expansion within the Web3 and crypto domains.',
				'',
				''
			]
		}
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

<div class="team" id="team">
	<div class="content">
		<div class="sticky">
			<img class="title" src="/images/team.svg" alt="The InpulseX Team" />
			{#if members[currentIndex] && !transition}
				<div class="bio" transition:fade>
					<Title as="h4">{members[currentIndex].name}</Title>
					<Title as="h5">{members[currentIndex].role}</Title>
					{#each members[currentIndex].bio as paragraph}
						<Paragraph>{@html paragraph}</Paragraph>
					{/each}
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
		margin-bottom: -0.5em;
	}
	.bio :global(h5) {
		margin-bottom: 0.5em;
	}
	.bio :global(b) {
		font-weight: 700;
		font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu,
			Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
		font-size: 0.9em;
	}
</style>
