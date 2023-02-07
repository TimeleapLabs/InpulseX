const { expect } = require("chai");
const { ethers } = require("hardhat");

const tx = async (tx) => await (await tx).wait();

const deployAll = async () => {
  const Dummy20 = await ethers.getContractFactory("Dummy20");
  const dummy20 = await Dummy20.deploy();
  await dummy20.deployed();

  const Dummy721 = await ethers.getContractFactory("Dummy721");
  const dummy721 = await Dummy721.deploy();
  await dummy721.deployed();

  const Dummy1155 = await ethers.getContractFactory("Dummy1155");
  const dummy1155 = await Dummy1155.deploy();
  await dummy1155.deployed();

  const Dummy1363 = await ethers.getContractFactory("Dummy1363");
  const dummy1363 = await Dummy1363.deploy();
  await dummy1363.deployed();

  const ERC20StakerERC20Rewarder = await ethers.getContractFactory(
    "ERC20StakerERC20Rewarder"
  );
  const erc20StakerERC20Rewarder = await ERC20StakerERC20Rewarder.deploy();
  await erc20StakerERC20Rewarder.deployed();

  const ERC20StakerERC1155Rewarder = await ethers.getContractFactory(
    "ERC20StakerERC1155Rewarder"
  );
  const erc20StakerERC1155Rewarder = await ERC20StakerERC1155Rewarder.deploy();
  await erc20StakerERC1155Rewarder.deployed();

  const ERC721StakerERC20Rewarder = await ethers.getContractFactory(
    "ERC721StakerERC20Rewarder"
  );
  const erc721StakerERC20Rewarder = await ERC721StakerERC20Rewarder.deploy();
  await erc721StakerERC20Rewarder.deployed();

  const ERC721StakerERC1155Rewarder = await ethers.getContractFactory(
    "ERC721StakerERC1155Rewarder"
  );
  const erc721StakerERC1155Rewarder =
    await ERC721StakerERC1155Rewarder.deploy();
  await erc721StakerERC1155Rewarder.deployed();

  const ERC1155StakerERC20Rewarder = await ethers.getContractFactory(
    "ERC1363StakerERC20Rewarder"
  );
  const erc1155StakerERC20Rewarder = await ERC1155StakerERC20Rewarder.deploy();
  await erc1155StakerERC20Rewarder.deployed();

  const ERC1155StakerERC1155Rewarder = await ethers.getContractFactory(
    "ERC1155StakerERC1155Rewarder"
  );
  const erc1155StakerERC1155Rewarder =
    await ERC1155StakerERC1155Rewarder.deploy();
  await erc1155StakerERC1155Rewarder.deployed();

  const ERC1363StakerERC20Rewarder = await ethers.getContractFactory(
    "ERC1363StakerERC20Rewarder"
  );
  const erc1363StakerERC20Rewarder = await ERC1363StakerERC20Rewarder.deploy();
  await erc1363StakerERC20Rewarder.deployed();

  const ERC1363StakerERC1155Rewarder = await ethers.getContractFactory(
    "ERC1363StakerERC1155Rewarder"
  );
  const erc1363StakerERC1155Rewarder =
    await ERC1363StakerERC1155Rewarder.deploy();
  await erc1363StakerERC1155Rewarder.deployed();

  return {
    dummy20,
    dummy721,
    dummy1155,
    dummy1363,
    erc20StakerERC20Rewarder,
    erc20StakerERC1155Rewarder,
    erc721StakerERC20Rewarder,
    erc721StakerERC1155Rewarder,
    erc1155StakerERC20Rewarder,
    erc1155StakerERC1155Rewarder,
    erc1363StakerERC20Rewarder,
    erc1363StakerERC1155Rewarder,
  };
};

describe("Staking", function () {
  it("All contracts should be deployable", async function () {
    const contracts = await deployAll();
    expect(
      Object.values(contracts)
        .map((contract) => contract.address)
        .map((address) => address.match(/0x[a-f0-9]{40}/i))
        .every(Boolean)
    ).to.be.true;
  });
});
