import fetch from "node-fetch";

export const getIpxUSDPrice = async () => {
  const req = await fetch(
    "https://api.coingecko.com/api/v3/simple/price?ids=inpulse-x-2&vs_currencies=usd"
  );

  const res = await req.json();
  return res["inpulse-x-2"].usd;
};
