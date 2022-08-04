const { ethers } = require("hardhat")

async function callFunction() {
  // ethers.getContractAt is a hardhat-specific function!
  // calling contract functions will need to be done a different way on any front-end website,
  // this file is just to test that you can call the diamond and run functions correctly

    const diamondAddress = "0x78f7cF61262C7236FEd5555B26A363C9235C189d";

    const contract = await ethers.getContractAt('IDiamondLoupe', diamondAddress)
    console.log(await contract.facets())

    // --------------------------------------------------------------------------------------

    // const contract = await ethers.getContractAt('OwnershipFacet', diamondAddress)
    // const signers = await ethers.getSigners()

    // console.log("Current contract owner:", await contract.owner())

    // const result = await contract.isAdmin(signers[1].address)
    // console.log("Signer 1 is admin:", result)

    // const txn = await contract.connect(signers[1]).transferOwnership(signers[0].address)
    // await txn.wait();

    // console.log("New contract owner:", await contract.owner())

    // --------------------------------------------------------------------------------------

    // const contract = await ethers.getContractAt('AdminPauseFacet', diamondAddress)

    // const txn = await contract.togglePause()
    // await txn.wait();

    // console.log(await contract.paused())
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    callFunction()
      .then(() => process.exit(0))
      .catch(error => {
        console.error(error)
        process.exit(1)
      })
  }