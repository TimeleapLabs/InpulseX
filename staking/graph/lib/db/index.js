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

export const getPoints = async (request) => {
  const db = await getDB();

  const collection = db.collection("inpulsexTiers");
  const query = {};

  if (request.arguments.address) {
    query["user"] = request.arguments.address;
  }

  const results = await collection.find(query).toArray();
  return results;
};

export const getRewards = async (request) => {
  const db = await getDB();

  const collection = db.collection("inpulsexStakeRewards");
  const query = {};

  if (request.arguments.address) {
    query["contract"] = request.arguments.address;
  }

  const results = await collection.find(query).toArray();
  return results;
};
