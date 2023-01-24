# InpulseX Project Monorepo

This mono-repo contains the following InpulseX projects:

- [Token](./token/): ERC1363 token
- [Migrate](./migrate/): Migration scripts and smart contracts
- [Staking](./staking/): Staking smart contracts
- [PegSwap](./pegswap/): PegSwap (multichain) smart contracts
- [UI](./ui/): UI/UX for the staking and pegswap oracles

## Tech stack

- [Hardhat](https://hardhat.org/) is used for smart contract development and scaffolding
- [Waffle](https://getwaffle.io/) and [Chai](https://www.chaijs.com/) are used for smart contract testing
- [SvelteKit](https://kit.svelte.dev/) is used for UI

## Standards

- The IPX token implements the [ERC20](https://eips.ethereum.org/EIPS/eip-20),
  [ERC165](https://eips.ethereum.org/EIPS/eip-165), and
  [ERC1363](https://eips.ethereum.org/EIPS/eip-1363) protocols.
- The IPX PegSwap implements the [ERC712](https://eips.ethereum.org/EIPS/eip-712) protocol.
- The IPX staking contracts implement the [ERC1363](https://eips.ethereum.org/EIPS/eip-1363)
  receiver protocol for a more smooth and more gas-efficient experience.
