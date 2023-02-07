const { expect } = require("chai");
const { ethers } = require("hardhat");

const tx = async (tx) => await (await tx).wait();

const TRANSFER721 = "safeTransferFrom(address,address,uint256)";

const later = (days) =>
  Math.floor(new Date().valueOf() / 1000) + days * 60 * 60 * 24 * 1000;

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
    "ERC1155StakerERC20Rewarder"
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

  it("ERC20Staker should not allow unstaking before unlock", async function () {
    const { dummy20: token, erc20StakerERC20Rewarder: staker } =
      await deployAll();
    const [_owner, user] = await ethers.getSigners();

    await tx(token.transfer(user.address, 100));
    await tx(staker.setStakingToken(token.address));
    await tx(staker.setUnlockTime(later(1)));
    await tx(token.connect(user).approve(staker.address, 100));
    await tx(staker.connect(user).stake(100));

    await expect(staker.connect(user).unstake()).to.be.revertedWith(
      "Cannot unstake yet"
    );
  });

  it("ERC1363Staker should not allow unstaking before unlock", async function () {
    const { dummy1363: token, erc1363StakerERC20Rewarder: staker } =
      await deployAll();
    const [_owner, user] = await ethers.getSigners();

    await tx(token.transfer(user.address, 100));
    await tx(staker.setStakingToken(token.address));
    await tx(staker.setUnlockTime(later(1)));
    await tx(token.connect(user).transferAndCall(staker.address, 100, 0x0));

    await expect(staker.connect(user).unstake()).to.be.revertedWith(
      "Cannot unstake yet"
    );
  });

  it("ERC721Staker should not allow unstaking before unlock", async function () {
    const { dummy721: token, erc721StakerERC20Rewarder: staker } =
      await deployAll();
    const [owner, user] = await ethers.getSigners();

    await tx(token[TRANSFER721](owner.address, user.address, 0));
    await tx(staker.setStakingToken(token.address));
    await tx(staker.setUnlockTime(later(1)));
    await tx(token.connect(user).approve(staker.address, 0));
    await tx(staker.connect(user).stake(0));

    await expect(staker.connect(user).unstake()).to.be.revertedWith(
      "Cannot unstake yet"
    );
  });

  it("ERC1155Staker should not allow unstaking before unlock", async function () {
    const { dummy1155: token, erc1155StakerERC20Rewarder: staker } =
      await deployAll();
    const [owner, user] = await ethers.getSigners();

    await tx(token.safeTransferFrom(owner.address, user.address, 0, 100, 0x0));
    await tx(staker.setStakingToken(token.address, 0));
    await tx(staker.setUnlockTime(later(1)));
    await tx(token.connect(user).setApprovalForAll(staker.address, true));
    await tx(staker.connect(user).stake(100));

    await expect(staker.connect(user).unstake()).to.be.revertedWith(
      "Cannot unstake yet"
    );
  });
});
