require("@nomiclabs/hardhat-waffle");
require("solidity-coverage");
require("hardhat-contract-sizer");
require("hardhat-abi-exporter");
require("hardhat-gas-reporter");
require("solidity-docgen");
require("@nomiclabs/hardhat-etherscan");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    testnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
    },
    mainnet: {
      url: `https://eth.llamarpc.com`,
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: "Q7NTB1WSX8RYMPZSVDZ86YA5R5P15CHJ8P",
  },
};
