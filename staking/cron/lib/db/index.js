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

export const getAllPoints = async () => {
  const db = await getDB();
  const collection = db.collection("inpulsexTiers");
  return await collection.find().toArray();
};

export const recordTiers = async (users) => {
  const db = await getDB();
  const collection = db.collection("inpulsexRecordedTiers");
  const needsUpdate = [];
  for (const { user, tier } of users) {
    const { modifiedCount, upsertedCount } = await collection.updateOne(
      { user },
      { $set: { tier } },
      { upsert: true }
    );
    if (modifiedCount || upsertedCount) {
      needsUpdate.push({ user, tier });
    }
  }
  return needsUpdate;
};

export const getTiers = async () => {
  const db = await getDB();
  const collection = db.collection("inpulsexRecordedTiers");
  return await collection.find({}).toArray();
};
