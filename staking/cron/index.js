import { getContract } from "./lib/blockchain/providers.js";
import { getAllPoints, recordTiers } from "./lib/db/index.js";

const contractTierMap = {
  // 18 months single
  "0x6aa00f43372c4951f1485994aa59d5a8d6f38880": [
    { amount: 12500, tier: "super_xstronaut" },
    { amount: 5000, tier: "space_major" },
    { amount: 2000, tier: "space_captain" },
    { amount: 1000, tier: "recruit" },
    { amount: 250, tier: "trainee" },
  ],
  // 6 months single
  "0x2ce9a2253c6aca52923d0c8467deccc5dd6ba60e": [
    { amount: Infinity, tier: "super_xstronaut" },
    { amount: 10000, tier: "space_major" },
    { amount: 4000, tier: "space_captain" },
    { amount: 1500, tier: "recruit" },
    { amount: 750, tier: "trainee" },
  ],
  // 6 months single
  "0x2d55f2dda62184bcf43d8f3cb0e9bd16ddd20b8a": [
    { amount: Infinity, tier: "super_xstronaut" },
    { amount: 10000, tier: "space_major" },
    { amount: 4000, tier: "space_captain" },
    { amount: 1500, tier: "recruit" },
    { amount: 750, tier: "trainee" },
  ],
  // 4 months single
  "0x1E91d3cBB3FA37740f5e731AAfDa4756Ab8990E2": [
    { amount: Infinity, tier: "super_xstronaut" },
    { amount: 10000, tier: "space_major" },
    { amount: 4000, tier: "space_captain" },
    { amount: 1500, tier: "recruit" },
    { amount: 750, tier: "trainee" },
  ],
  // 8 months single
  "0xbbEe2605c000372EfF418936510BDD7Fbd8e036F": [
    { amount: Infinity, tier: "super_xstronaut" },
    { amount: 10000, tier: "space_major" },
    { amount: 4000, tier: "space_captain" },
    { amount: 1500, tier: "recruit" },
    { amount: 750, tier: "trainee" },
  ],
  // lp
  "0xa4191eb9b4e9cec404e9a03c7a09b72a6cca8013": [
    { amount: 6250, tier: "super_xstronaut" },
    { amount: 2500, tier: "space_major" },
    { amount: 1000, tier: "space_captain" },
    { amount: 500, tier: "recruit" },
    { amount: 250, tier: "trainee" },
  ],
};
const contractDurationMap = {
  "0x6aa00f43372c4951f1485994aa59d5a8d6f38880": 18,
  "0x2ce9a2253c6aca52923d0c8467deccc5dd6ba60e": 6,
  "0x2d55f2dda62184bcf43d8f3cb0e9bd16ddd20b8a": 6,
  "0xa4191eb9b4e9cec404e9a03c7a09b72a6cca8013": 12,
  "0x1E91d3cBB3FA37740f5e731AAfDa4756Ab8990E2": 4,
  "0xbbEe2605c000372EfF418936510BDD7Fbd8e036F": 8,
};

const tierScores = {
  super_xstronaut: 5,
  space_major: 4,
  space_captain: 3,
  recruit: 2,
  trainee: 1,
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
        const amountFromSrc =
          (data[renotmalize_from] * srcDuration) / destDuration;
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
  const userTx = allTx.filter(
    (tx) => tx.user.toLowerCase() === address.toLowerCase()
  );
  const data = composite(aggregate(userTx || []));
  const tiers = Object.entries(data)
    .map(getTierByContract)
    .filter(Boolean)
    .sort(sortTiers);
  return tiers.length
    ? {
        user: address,
        tier: tierScores[tiers[0]],
      }
    : null;
};

export const handler = async () => {
  const points = await getAllPoints();
  const uniqueUsers = [...new Set(points.map((tx) => tx.user.toLowerCase()))];
  const tiers = uniqueUsers.map(getTier(points)).filter(Boolean);
  const needsUpdate = await recordTiers(tiers);

  console.log({ needsUpdate });

  if (needsUpdate.length) {
    const users = needsUpdate.map((item) => item.user);
    const tiers = needsUpdate.map((item) => item.tier);
    const contract = getContract();
    await contract.grantTiers(users, tiers);
  }

  return {
    statusCode: 200,
  };
};
