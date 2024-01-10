<script>
	import Card from './Card.svelte';

	export let address;
	export let tier = '';

	const tiersEndpoint = 'https://29q4wlts70.execute-api.us-east-1.amazonaws.com/v1/tiers';

	const getQuery = (address) => `{
    getTiers(address: "${address}") {
      usd
			contract
    }
  }`;

	const contractTierMap = {
		// 18 months single
		'0x6aa00f43372c4951f1485994aa59d5a8d6f38880': [
			{ amount: 12500, tier: 'super_xstronaut' },
			{ amount: 5000, tier: 'space_major' },
			{ amount: 2000, tier: 'space_captain' },
			{ amount: 1000, tier: 'recruit' },
			{ amount: 250, tier: 'trainee' }
		],
		// 6 months single
		'0x2ce9a2253c6aca52923d0c8467deccc5dd6ba60e': [
			{ amount: Infinity, tier: 'super_xstronaut' },
			{ amount: 10000, tier: 'space_major' },
			{ amount: 4000, tier: 'space_captain' },
			{ amount: 1500, tier: 'recruit' },
			{ amount: 750, tier: 'trainee' }
		],
		// 6 months single
		'0x2d55f2dda62184bcf43d8f3cb0e9bd16ddd20b8a': [
			{ amount: Infinity, tier: 'super_xstronaut' },
			{ amount: 10000, tier: 'space_major' },
			{ amount: 4000, tier: 'space_captain' },
			{ amount: 1500, tier: 'recruit' },
			{ amount: 750, tier: 'trainee' }
		],
		// lp
		'0xa4191eb9b4e9cec404e9a03c7a09b72a6cca8013': [
			{ amount: 6250, tier: 'super_xstronaut' },
			{ amount: 2500, tier: 'space_major' },
			{ amount: 1000, tier: 'space_captain' },
			{ amount: 500, tier: 'recruit' },
			{ amount: 250, tier: 'trainee' }
		]
	};

	const contractDurationMap = {
		'0x6aa00f43372c4951f1485994aa59d5a8d6f38880': 18,
		'0x2ce9a2253c6aca52923d0c8467deccc5dd6ba60e': 6,
		'0x2d55f2dda62184bcf43d8f3cb0e9bd16ddd20b8a': 6,
		'0xa4191eb9b4e9cec404e9a03c7a09b72a6cca8013': 12
	};

	const tierScores = {
		super_xstronaut: 4,
		space_major: 3,
		space_captain: 2,
		recruit: 1,
		trainee: 0
	};

	const aggregate = (data) => {
		const values = {};
		for (const entry of data) {
			if (!values[entry.contract]) {
				values[entry.contract] = 0;
			}
			values[entry.contract] += entry.usd;
		}
		return values;
	};

	const composite = (data) => {
		const clone = { ...data };
		for (const renotmalize_to in data) {
			for (const renotmalize_from in data) {
				if (renotmalize_from !== renotmalize_to) {
					const destDuration = contractDurationMap[renotmalize_to];
					const srcDuration = contractDurationMap[renotmalize_from];
					const amountFromSrc = (data[renotmalize_from] * srcDuration) / destDuration;
					clone[renotmalize_to] += amountFromSrc;
				}
			}
		}
		return clone;
	};

	const getTierByContract = ([contract, usd]) => {
		for (const { amount, tier } of contractTierMap[contract]) {
			if (usd >= amount) {
				return tier;
			}
		}
	};

	const sortTiers = (t1, t2) => tierScores[t2] - tierScores[t1];

	const getTier = async (address) => {
		if (!address) {
			return;
		}
		const query = getQuery(address);
		const req = await fetch(tiersEndpoint, { method: 'POST', body: JSON.stringify({ query }) });
		const res = await req.json();
		const data = composite(aggregate(res?.data?.getTiers || []));
		const tiers = Object.entries(data).map(getTierByContract).filter(Boolean).sort(sortTiers);
		tier = tiers[0];
	};

	$: if (address) getTier(address);
</script>

{#if tier}
	<div class="tier">
		<Card>
			<video src="/videos/tiers/{tier}.compressed.mp4" alt={tier} autoplay muted loop />
		</Card>
	</div>
{/if}

<style>
	video {
		width: 100%;
		height: 100%;
		object-fit: cover;
		margin-bottom: -4px;
	}
	.tier :global(.card) {
		padding: 0;
		overflow: hidden;
	}
</style>
