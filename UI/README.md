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

### Swap

Consists of three subcomponents:

1. `PastClaim` component, displaying one unclaimed user bridge request
2. `RequestSwap` component, to allow users to request a bridge from one chain to another
3. `Swap` component, which combines the two above components into one package

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
