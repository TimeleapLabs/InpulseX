import { getProvider } from "./providers.js";
import { rpcList } from "./list.js";
import { ethers } from "ethers";

const abi = ["event Staked(address user, uint256 amount)"];
const iface = new ethers.utils.Interface(abi);
const provider = getProvider(rpcList["ethereum-mainnet"]);

const tryParse = (log) => {
  try {
    return iface.parseLog(log);
  } catch (error) {
    return null;
  }
};

export const getUser = async (entry) => {
  const tx = await provider.getTransactionReceipt(entry.transaction.hash);
  const { user } = tx.logs.map(tryParse).filter(Boolean).pop().args;
  return user;
};
