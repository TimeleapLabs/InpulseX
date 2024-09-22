import { ethers } from "ethers";
import { rpcList } from "./list.js";
import abi from "./abi.js";

const providerCache = {};

export const getProvider = (rpc) => {
  if (!providerCache[rpc]) {
    providerCache[rpc] = rpc.startsWith("wss")
      ? new ethers.providers.WebSocketProvider(rpc)
      : new ethers.providers.JsonRpcProvider(rpc);
  }
  return providerCache[rpc];
};

export const getWallet = () =>
  new ethers.Wallet(
    process.env.PRIVATE_KEY,
    getProvider(rpcList["arbitrum-nova"])
  );

export const getContract = () =>
  new ethers.Contract(process.env.NFT_ADDRESS, abi, getWallet());
