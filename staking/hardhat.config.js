require("@nomiclabs/hardhat-waffle");
require("solidity-coverage");
require("hardhat-contract-sizer");
require("hardhat-abi-exporter");
require("solidity-docgen");
require("@nomicfoundation/hardhat-verify");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    bsc: {
      url: "https://bsc-dataseed.binance.org/",
    },
  },
  etherscan: {
    apiKey: "I5ZIY76T8ABF4YBSWVHDA6CQNEQDBZMGMZ",
  },
};
