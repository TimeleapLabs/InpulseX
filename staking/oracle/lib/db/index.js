import { MongoClient } from "mongodb";
import { getSecrets } from "../secrets.js";

const options = {
  useUnifiedTopology: true,
  useNewUrlParser: true,
};

let cachedClient;

const connect = async (retries = 5) => {
  if (cachedClient) {
    return cachedClient;
  }
  const { MONGODB_URI } = await getSecrets("secrets/inpulsex/db");
  while (retries--) {
    try {
      const connection = new MongoClient(MONGODB_URI, options);
      const client = await connection.connect();
      cachedClient = client;
      return client;
    } catch (error) {
      if (!retries) {
        throw error;
      }
    }
  }
};

export const getDB = async () => {
  const client = await connect();
  const { DB_NAME } = await getSecrets("secrets/inpulsex/db");
  return client.db(DB_NAME);
};

export const upsertPoint = async (hash, point) => {
  const db = await getDB();
  const collection = db.collection("inpulsexTiers");
  return await collection.updateOne(
    { hash },
    { $set: point },
    { upsert: true }
  );
};

export const addRewards = async (hash, point) => {
  const db = await getDB();
  const collection = db.collection("inpulsexStakeRewards");
  return await collection.updateOne(
    { hash },
    { $set: point },
    { upsert: true }
  );
};
