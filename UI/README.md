# InpulseX UI

## Dependencies

Run the following command to install the project dependencies:

```bash
npm i
```

## Run the development server

The following command starts the development server, opening the project in your
browser:

```
npm run dev -- --open
```

## Components

### Connect

Connect components consists of a movable "Connect button" to allow users to connect
their wallets to the InpulseX dApp.

The connect button uses the "Onboard" library to display a dialog for selecting and
connecting wallets.

#### Example usage

```svelte
<ConnectButton />
```

### Swap

Consists of three subcomponents:

1. `PastClaim` component, displaying one unclaimed user bridge request
2. `RequestSwap` component, to allow users to request a bridge from one chain to another
3. `Swap` component, which combines the two above components into one package

#### Example usage

```svelte
<Swap />
```

### Staking

Four staking components are in this project:

1. `ERC20Stake` allows the staking of ERC20 tokens.
2. `ERC1363Stake` allows the staking of ERC1363 tokens.
3. `ERC1155Stake` allows the staking of ERC1155 multi-token standard.
4. `ERC721Stake` allows the staking of ERC721 NFTs.

These components accept the following options:

- `title`: The title of the staking component
- `address`: The address of the staking contract
- `maxMinted`: Maximum number of minted NFTs in this collection (only for ERC721)
- `bucketSize`: Maximum number of NFTs to query for finding user's NFTs (only for ERC721)
- `nftId`: The NFT ID users should stake (only for ERC1155)
- `stakeSymbol`: The symbol of the staking token/NFT
- `stakeLogo`: The logo of the staking token/NFT
- `rewardSymbol`: The symbol of the reward token/NFT
- `rewardLogo`: The logo of the reward token/NFT
- `start`: The start date of staking

#### Example usage

```svelte
<ERC1363Stake
	title="Stake IPX"
	start={new Date('2023-03-31T18:22:07.831Z')}
	address="0xb7D3C2825866D8523bE8B8aa4ad0eAbADc34B580"
	rewardSymbol="GC"
	rewardLogo="https://pools.outerringmmo.com/assets/images/gq.png"
	stakeLogo="https://pools.outerringmmo.com/assets/images/IPX.png"
/>
```
