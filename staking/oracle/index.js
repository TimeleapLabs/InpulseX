import { chainIds } from "./lib/blockchain/list.js";
import { upsertPoint } from "./lib/db/index.js";
import { getUser } from "./lib/blockchain/user.js";
import { ethers } from "ethers";
import { addRewards } from "./lib/db/index.js";

import { getEthUSDPrice, getIpxEthPrice } from "./lib/blockchain/uniswap.js";
import { getIpxUSDPrice } from "./lib/blockchain/coingecko.js";

export const handler = async ({ body }) => {
  if (!body) {
    return {
      statusCode: 400,
      body: "Request body is empty!",
    };
  }
  const request = JSON.parse(body);
  console.log({ request });
  if (!request.entry) {
    return {
      statusCode: 400,
      body: "`entry` is required",
    };
  }
  if (!request.blockchain) {
    return {
      statusCode: 400,
      body: "`blockchain` is required",
    };
  }
  if (!chainIds[request.blockchain]) {
    return {
      statusCode: 400,
      body: "`blockchain` is invalid",
    };
  }
  const blockInfo = {
    block: request.entry.block.number,
    contract: request.entry.block.address,
  };
  const { hash } = request.entry.transaction;
  if (request.entry.event.name === "StakedLP") {
    const user = await getUser(request.entry);
    const ethUsdPrice = await getEthUSDPrice();
    const ipxEthPrice = await getIpxEthPrice();
    const eth = Number(ethers.utils.formatEther(request.entry.event.args.eth));
    const ipx = eth / ipxEthPrice;
    const usd = ethUsdPrice * eth;
    await upsertPoint(hash, { user, usd, eth, ipx, ...blockInfo });
  } else if (request.entry.event.name === "Staked") {
    const { user, amount } = request.entry.event.args;
    const ipxEthPrice = await getIpxEthPrice();
    const ipxUSDPrice = await getIpxUSDPrice();
    const ipx = Number(ethers.utils.formatUnits(amount));
    const usd = ipx * ipxUSDPrice;
    const eth = ipx * ipxEthPrice;
    await upsertPoint(hash, { user, usd, eth, ipx, ...blockInfo });
  } else {
    const added = Number(
      ethers.utils.formatUnits(request.entry.event.args.amount)
    );
    await addRewards(hash, { added, ...blockInfo });
  }
  return {
    statusCode: 200,
    body: JSON.stringify({ abort: true }),
  };
};
