const ethers = require("ethers");
const fs = require("fs");
const exported = require("./bscScanExport.json");

const holders = exported.map((line) => line.HolderAddress);
const provider = ethers.providers.JsonRpcProvider(process.env.PROVIDER);

const abi = ["function balanceOf(address user) external"];
const address = "0x1A3eE33da561642bA6bE4671A06267ee0F36cEDd";

const contract = new ethers.Contract(address, abi, provider);
const blockTag = "latest";

const getBalance = async (user) => {
  return await contract.balanceOf(user, { blockTag });
};

const balances = {};

let i = 1;
for (const holder of holders) {
  console.log(`- [${i++}/${holders.length}]\t\tGetting balance of ${holder}`);
  balances[holder] = await getBalance(holder);
}

fs.writeFileSync("./balances.json", JSON.stringify(balances));
