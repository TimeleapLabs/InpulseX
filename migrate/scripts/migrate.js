const ethers = require("ethers");
const balances = require("./balances.json");
require("dotenv").config();

function* getChunks(arr, n) {
  for (let i = 0; i < arr.length; i += n) {
    yield arr.slice(i, i + n);
  }
}

const provider = ethers.providers.JsonRpcProvider(process.env.PROVIDER);
const address = "";

const abi = [
  "function bulkAirdrop(address[] addresses, uint256[] balances, uint256 length) external",
];

const contract = new ethers.Contract(address, abi, provider);

const airdrop = async (addresses, balances) => {
  return await contract.bulkAirdrop(addresses, balances, balances.length);
};

const chunks = [...getChunks(Object.entries(balances), 200)];

for (const chunk of chunks) {
  const addresses = chunk.map((d) => d[0]);
  const balances = chunk.map((d) => d[1]);
  await airdrop(addresses, balances);
}
