<script>
	import Title from '../../../lib/components/Title.svelte';
	import DataTable from '../../../lib/components/DataTable.svelte';
	import BaseStaking from '../../../lib/abi/staking/contracts/Base.sol/BaseStaking.json';
	import TextInput from '../../../lib/components/TextInput.svelte';

	import { getStakings } from '../../../lib/api';
	import { onMount } from 'svelte';
	import { ethers } from 'ethers';
	import { wallet } from '../../../stores/wallet';

	const admins = [
		'0xA2dEc4f8089f89F426e6beB76B555f3Cf9E7f499',
		'0x1c2650C3C43bB490710fCC1048636AD79f21EBD9',
		'0x033B52b62958352eF5c3D255468c4dcE3f1626B3'
	];

	let userAddress;

	const onProvider = async () => {
		const provider = new ethers.providers.Web3Provider($wallet.provider);
		const signer = provider.getSigner();
		userAddress = await signer.getAddress();
	};

	$: if ($wallet?.provider) onProvider();

	let stakings = [];
	let rewardMap = {};

	const tiersEndpoint = 'https://29q4wlts70.execute-api.us-east-1.amazonaws.com/v1/tiers';

	const timestampMap = {
		Ethereum: { block: 17465456, timestamp: 1686583739000, blocktime: 12000 },
		Binance: { block: 28698396, timestamp: 1685548351000, blocktime: 2700 }
	};

	const query = `{
    getTiers {
			user
      usd
			ipx
			eth
			block
			contract
    }
  }`;

	const rewardsQuery = `{
    getRewards {
			added
			contract
    }
  }`;

	const unlockCache = {};

	const rpcs = {
		Ethereum: new ethers.providers.JsonRpcProvider('https://eth.llamarpc.com'),
		Binance: new ethers.providers.JsonRpcProvider('https://bsc-dataseed3.binance.org')
	};

	const getUnlock = async (chain, address) => {
		if (!unlockCache[address]) {
			const contract = new ethers.Contract(address, BaseStaking, rpcs[chain]);
			unlockCache[address] = (await contract.getUnlockTime()) * 1000;
		}
		return unlockCache[address];
	};

	const aggregate = (data) => {
		const values = {};
		for (const entry of data) {
			if (!values[entry.user]) {
				values[entry.user] = { weight: 0, ipx: 0, duration: 0 };
			}
			values[entry.user].duration =
				(values[entry.user].duration * values[entry.user].ipx + entry.duration * entry.ipx) /
				(entry.ipx + values[entry.user].ipx);
			values[entry.user].weight += entry.weight;
			values[entry.user].ipx += entry.ipx || 0;
			if (!values[entry.user].date) {
				values[entry.user].date = new Date(entry.timestamp).toLocaleDateString();
			}
			//values[entry.user].eth += entry.eth || 0;
		}
		return values;
	};

	const nameMap = {
		Ethereum: 'Ethereum',
		Binance: 'BSC'
	};

	onMount(async () => {
		const response = await getStakings();

		const contracts = Object.fromEntries(
			response
				.map((col) => col.contracts.map(({ contract, name }) => ({ ...col, contract, name })))
				.flat()
				.map((col) => [col.contract.toLowerCase(), { ...col, stakes: [], weight: 0 }])
		);

		const req = await fetch(tiersEndpoint, { method: 'POST', body: JSON.stringify({ query }) });
		const res = await req.json();

		console.log(res.data.getTiers);
		const uniqueUsers = [...new Set(res.data.getTiers.map((tx) => tx.user))];
		console.log(uniqueUsers.map(getTier(res.data.getTiers)).filter(Boolean));

		const rreq = await fetch(tiersEndpoint, {
			method: 'POST',
			body: JSON.stringify({ query: rewardsQuery })
		});
		const rewards = await rreq.json();

		rewardMap = rewards.data.getRewards.reduce((result, item) => {
			result[item.contract] = result[item.contract] || 0;
			result[item.contract] += item.added;
			return result;
		}, {});

		for (const stake of res.data.getTiers) {
			const contract = contracts[stake.contract.toLowerCase()];
			const chainInfo = timestampMap[contract.blockchain];
			const unlockTime = await getUnlock(contract.blockchain, contract.contract);
			const timestamp = new Date(
				chainInfo.timestamp + (stake.block - chainInfo.block) * chainInfo.blocktime
			);
			const weight = unlockTime * stake.ipx;
			contract.weight += weight;
			contract.stakes.push({
				...stake,
				timestamp,
				weight,
				duration: unlockTime - timestamp.valueOf()
			});
			contract.unlockTime = unlockTime;
		}

		for (const key in contracts) {
			const contract = contracts[key];
			contract.aggregate = aggregate(contract.stakes);
		}

		stakings = Object.values(contracts);
	});

	const toTableData = (aggregate, rewards, totalWeight) =>
		Object.entries(aggregate).map(([user, stake], index) => {
			const earned = (Math.floor(stake.weight) / totalWeight) * (rewards || 0);
			const ratioEarned = earned / stake.ipx;
			const months = stake.duration / (30 * 24 * 60 * 60 * 1000);
			const apy = 100 * ratioEarned * (12 / months);
			return [
				index + 1,
				user,
				stake.date,
				Math.floor(stake.weight),
				`${stake.ipx.toFixed(4)} IPX`,
				`${earned.toFixed(4)} IPX`,
				`%${apy.toFixed(2)}`
			];
		});

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
		// 4 months single
		'0x1E91d3cBB3FA37740f5e731AAfDa4756Ab8990E2': [
			{ amount: Infinity, tier: 'super_xstronaut' },
			{ amount: 10000, tier: 'space_major' },
			{ amount: 4000, tier: 'space_captain' },
			{ amount: 1500, tier: 'recruit' },
			{ amount: 750, tier: 'trainee' }
		],
		// 8 months single
		'0xbbEe2605c000372EfF418936510BDD7Fbd8e036F': [
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
		'0xa4191eb9b4e9cec404e9a03c7a09b72a6cca8013': 12,
		'0x1E91d3cBB3FA37740f5e731AAfDa4756Ab8990E2': 4,
		'0xbbEe2605c000372EfF418936510BDD7Fbd8e036F': 8
	};

	const tierScores = {
		super_xstronaut: 4,
		space_major: 3,
		space_captain: 2,
		recruit: 1,
		trainee: 0
	};

	const aggregateForTier = (data) => {
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

	const getTier = (allTx) => (address) => {
		const userTx = allTx.filter((tx) => tx.user.toLowerCase() === address.toLowerCase());
		const data = composite(aggregateForTier(userTx || []));
		const tiers = Object.entries(data).map(getTierByContract).filter(Boolean).sort(sortTiers);
		return tiers.length
			? {
					tier: tiers[0],
					user: address,
					level:
						['trainee', 'recruit', 'space_captain', 'space_major', 'super_xstronaut'].indexOf(
							tiers[0]
						) + 1
			  }
			: null;
	};
</script>

{#if !userAddress || !admins.includes(userAddress)}
	<div class="no-access">You do not have access to this page.</div>
{:else}
	{#each stakings as { contract, name, blockchain, aggregate, weight }}
		<div class="table">
			<Title>{name} on {nameMap[blockchain]}</Title>
			<TextInput
				label="Rewards"
				placeholder="Input rewards (IPX) to calculate APY"
				bind:value={rewardMap[contract.toLowerCase()]}
			/>
			<DataTable
				data={toTableData(aggregate, rewardMap[contract.toLowerCase()], weight)}
				columns={['#', 'User', 'Date', 'Stake Weight', 'IPX Staked', 'IPX Earned', 'APY']}
			/>
		</div>
	{:else}
		<div class="loading">Loading...</div>
	{/each}
{/if}

<style>
	.no-access {
		padding: 8em 4em 8em 4em;
		min-height: calc(100vh - 186px);
		box-sizing: border-box;
	}
	.table {
		padding: 8em 4em 8em 0;
		box-sizing: border-box;
		max-width: 80%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		gap: 2em;
	}
	.table:not(:nth-of-type(1)) {
		padding-top: 0em;
	}
	.loading {
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 4em;
	}
</style>
