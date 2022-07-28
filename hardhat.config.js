
/* global ethers task */
require('@nomiclabs/hardhat-waffle')

require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task('accounts', 'Prints the list of accounts', async () => {
  const accounts = await ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
})

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: '0.8.7',
  networks: {
    rinkeby: {
      url: "https://rinkeby.infura.io/v3/731c65c5fa23442285d8eadf106f2bfb",
      accounts: ["5a0a487e36564f10a930591f0432aff3e4d5bcca026bca13feb7c20106948f19"]
    }
  },
  etherscan: {
    apiKey: "7H3W5RBZJQHBXZSM1G11AWKBSD356TNUJ1"
  }
  // settings: {
  //   optimizer: {
  //     enabled: true,
  //     runs: 200
  //   }
  // }
}
