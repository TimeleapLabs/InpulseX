import { getPoints, getRewards } from "./lib/db/index.js";

export const handler = async (request) => {
  try {
    if (request.info.fieldName === "getTiers") {
      return await getPoints(request);
    } else if (request.info.fieldName === "getRewards") {
      return await getRewards(request);
    }
  } catch (error) {
    return { error: error.message };
  }
};
