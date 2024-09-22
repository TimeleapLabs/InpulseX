import { PUBLIC_STRAPI_BASE_URL, PUBLIC_STRAPI_API_TOKEN } from '$env/static/public';

function makeRequest(path, method = 'GET', options = {}) {
	return fetch(new URL(path, PUBLIC_STRAPI_BASE_URL), {
		method,
		headers: {
			'Content-Type': 'application/json',
			Accept: 'application/json',
			Authorization: 'Bearer ' + PUBLIC_STRAPI_API_TOKEN
		},
		...options
	}).then((res) => res.json());
}

export function getImageFormatPath(imageData, size = 'large') {
	return new URL(imageData.data.attributes.formats[size].url, PUBLIC_STRAPI_BASE_URL).href;
}

export function getImagePath(imageData) {
	return new URL(imageData.data.attributes.url, PUBLIC_STRAPI_BASE_URL).href;
}

export async function getAboutSection() {
	const res = await makeRequest('/api/simple-sections/1');
	return res.data.attributes;
}

export async function getPhases() {
	const res = await makeRequest('/api/roadmaps?populate=*');
	return res.data.map((phase) => phase.attributes);
}

export async function getMembers() {
	const res = await makeRequest('/api/members?populate=*');
	return res.data.map((member) => member.attributes);
}

export async function getStakings() {
	const res = await makeRequest('/api/stakings?populate=*');
	return res.data.map((staking) => ({ ...staking.attributes, id: staking.id }));
}

export async function getStakingById(id) {
	const res = await makeRequest(`/api/stakings/${id}?populate=*`);
	return res.data.attributes;
}
