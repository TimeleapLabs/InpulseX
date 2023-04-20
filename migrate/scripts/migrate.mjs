import { ethers } from "ethers";
import fs from "fs";
import dotenv from "dotenv";
import cliProgress from "cli-progress";
import { getChunks } from "./common.mjs";
import { NonceManager } from "@ethersproject/experimental";

dotenv.config();

const balances = JSON.parse(fs.readFileSync("./balances.json"));
const provider = new ethers.providers.JsonRpcProvider(process.env.PROVIDER);
const signer = new ethers.Wallet(process.env.ADMIN_KEY, provider);
const manager = new NonceManager(signer);

const { migrationContractAddress } = JSON.parse(
  fs.readFileSync("./config.json")
);
const abi = [
  "function bulkAirdrop(address[] addresses, uint256[] balances) external",
];

const contract = new ethers.Contract(migrationContractAddress, abi, manager);

const airdrop = async (addresses, balances) => {
  return await contract.bulkAirdrop(addresses, balances);
};

const excluded = [
  "0x93dbdcfb4eff1ba07f013ae0c08b576378d3d42e".toLowerCase(),
  "0xb4a6890bd2fcbc43a6b364a6a54c6328e0e9684b".toLowerCase(),
  "0xb5d38ca2e0b3f23adddc6eee4f6bc290217bf8c5".toLowerCase(),
  "0xae20b98ab669db2c8520491c200963cccd0bbff3".toLowerCase(),
  "0x701ec60dba4f754489234bcd6fdb86e3750ebc6b".toLowerCase(),
  "0x0cde7de19d6940bcf7d490e588019cb3dc36e2b7".toLowerCase(),
  "0x514b55313ba707dbc0b218e8162913d072f1d9bf".toLowerCase(),
  "0x2e1589b568926971fec31c0b93e907a7ebae348d".toLowerCase(),
  "0x10b406cf5f077636831480f3e9894ca785ccefe2".toLowerCase(),
  "0x0Fca5fa1A32B35E861d0EDebDB97f9bC1cF9cB69".toLowerCase(),
  "0x23D5eD1a3B7791F0cBdC7383a34b4f7bD2147CAE".toLowerCase(),
  "0x81745d71bD543caEFE97d735b6D47A0c18570405".toLowerCase(),
  "0xe8d1969E9c21c6d16F23B58ea438F36d649cf6BC".toLowerCase(),
  "0x283B3b8f340E8FB94D55b17E906744a74074cD07".toLowerCase(),
  "0x22a3faA5Ee669C67709198b2BaA4512F46B698f6".toLowerCase(),
  "0xafd5ede8f2a5d712537d941d0ec20778bde2024f".toLowerCase(),
  "0xffefE959d8bAEA028b1697ABfc4285028d6CEB10".toLowerCase(),
];

const entries = Object.entries(balances).filter(
  ([address]) => !excluded.includes(address.toLowerCase())
);
const chunks = getChunks(entries, 200);

const bar = new cliProgress.SingleBar({}, cliProgress.Presets.shades_classic);
bar.start(entries.length, 0);

await Promise.all(
  [...chunks].map(async (chunk) => {
    const addresses = chunk.map((d) => d[0]);
    const balances = chunk.map((d) => ethers.BigNumber.from(d[1]).div(20000));
    await airdrop(addresses, balances);
    bar.increment(chunk.length);
  })
);

bar.stop();
