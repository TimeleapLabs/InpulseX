const { expect } = require("chai");
const { ethers } = require("hardhat");

const tx = async (tx) => await (await tx).wait();

describe("InpulseX", function () {
  it("Recovering InpulseX should not work", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner, addr1] = await ethers.getSigners();

    await tx(IPX.connect(_owner).transfer(IPX.address, "1000000000000"));

    await expect(
      IPX.recoverERC20(IPX.address, addr1.address, "100000000000")
    ).to.be.revertedWith("InpulseX: cannot recover IPX");
  });

  it("Shouldn't be able to transfer more than owned", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner, addr1, addr2] = await ethers.getSigners();

    await tx(IPX.connect(_owner).transfer(addr1.address, "1"));

    await expect(
      tx(IPX.connect(addr1).transfer(addr2.address, "2"))
    ).to.be.revertedWith("ERC20: transfer amount exceeds balance");
  });

  it("Base info should be set correctly on deploy", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner] = await ethers.getSigners();

    expect(await IPX.getOwner()).to.be.equal(_owner.address);
    expect(await IPX.decimals()).to.be.equal(18);
    expect(await IPX.symbol()).to.be.equal("IPX");
    expect(await IPX.name()).to.be.equal("InpulseX");
    expect(await IPX.totalSupply()).to.be.equal(
      "10000000000000000000000000000"
    );
  });

  it("Sending BNB to the contract should fail", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner] = await ethers.getSigners();

    const tx = _owner.sendTransaction({
      to: IPX.address,
      value: ethers.utils.parseEther("1.0"),
    });

    await expect(tx).to.be.reverted;
  });

  it("Ownership transfer should work", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner, addr1] = await ethers.getSigners();

    await IPX.transferOwnership(addr1.address);
    expect(await IPX.getOwner()).to.be.equal(addr1.address);

    await IPX.connect(addr1).renounceOwnership();
    expect(await IPX.getOwner()).to.be.equal(
      "0x0000000000000000000000000000000000000000"
    );
  });

  it("Transfer from should fail without allowance", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner, addr1] = await ethers.getSigners();

    await expect(
      tx(IPX.connect(addr1).transferFrom(_owner.address, addr1.address, "1"))
    ).to.be.revertedWith("ERC20: transfer amount exceeds allowance");
  });

  it("Approval and allowance should work", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner, addr1] = await ethers.getSigners();

    await IPX.approve(addr1.address, "100000000000");
    expect(await IPX.allowance(_owner.address, addr1.address)).to.be.equal(
      "100000000000"
    );

    await IPX.increaseAllowance(addr1.address, "100000000000");
    expect(await IPX.allowance(_owner.address, addr1.address)).to.be.equal(
      "200000000000"
    );

    await IPX.decreaseAllowance(addr1.address, "100000000000");
    expect(await IPX.allowance(_owner.address, addr1.address)).to.be.equal(
      "100000000000"
    );
  });

  it("Transfer from should pass with correct allowance", async function () {
    const InpulseX = await ethers.getContractFactory("InpulseX");
    const IPX = await InpulseX.deploy();
    await IPX.deployed();

    const [_owner, addr1] = await ethers.getSigners();

    await IPX.approve(addr1.address, "100000000000");

    await expect(
      IPX.connect(addr1).transferFrom(_owner.address, addr1.address, "1")
    ).to.not.be.reverted;
  });
});
