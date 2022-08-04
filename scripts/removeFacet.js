const { getSelectors, FacetCutAction } = require('./libraries/diamond.js')

const zeroAddress = "0x0000000000000000000000000000000000000000"
const diamondAddress = "0x78f7cF61262C7236FEd5555B26A363C9235C189d"

const nameOfFacetToBeRemoved = 'VarSetterFacet'
const facetToBeRemovedAddress = "0x1171927BF1014C6b40E3ca49F4a1cdd66946581E";

async function removeFacet() {
    const accounts = await ethers.getSigners()

    const facetToBeRemoved = await ethers.getContractAt(nameOfFacetToBeRemoved, facetToBeRemovedAddress)

    const cut = []
    cut.push({
        facetAddress: zeroAddress,
        action: FacetCutAction.Remove,
        functionSelectors: getSelectors(facetToBeRemoved)
    })

    // upgrade diamond with facets
    console.log('Diamond Cut:', cut)
    const diamondCut = await ethers.getContractAt('IDiamondCut', diamondAddress)
    let tx
    let receipt
    // diamondCut function can take arguments which will run init
    // functions on another contract, but I am choosing not to pass
    // these arguments in because the facet I am adding does not
    // need to run any functions on initialisation
    tx = await diamondCut.diamondCut(cut, zeroAddress, [])
    console.log('Diamond cut tx: ', tx.hash)
    receipt = await tx.wait()
    if (!receipt.status) {
      throw Error(`Diamond upgrade failed: ${tx.hash}`)
    }
    console.log('Completed diamond cut')
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    removeFacet()
      .then(() => process.exit(0))
      .catch(error => {
        console.error(error)
        process.exit(1)
      })
  }