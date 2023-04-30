import * as dotenv from 'dotenv';
import { GoogleSpreadsheet } from 'google-spreadsheet';
import { error } from '@sveltejs/kit';

dotenv.config();

/** @type {import('./$types').RequestHandler} */
export async function POST({ request }) {
	const { email } = await request.json();

	if (!email) {
		throw error(403, 'Email empty');
	}

	const doc = new GoogleSpreadsheet(process.env.GOOGLE_DOCUMENT_ID);

	await doc.useServiceAccountAuth({
		client_email: process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL,
		private_key: process.env.GOOGLE_PRIVATE_KEY
	});

	await doc.loadInfo();
	const sheet = doc.sheetsByIndex[0];
	const rows = await sheet.getRows();

	for (const row of rows) {
		if (row.Email !== email) {
			await sheet.addRow({ Email: email });
		}
	}

	return new Response('Email is required');
}
