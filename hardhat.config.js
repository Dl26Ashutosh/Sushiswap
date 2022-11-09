require("@nomiclabs/hardhat-waffle");
require("hardhat-tracer");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});


// While deploying contract put your private key here
const Private_Key = "PUT_YOUR_PRIVATE_KEY_OF_WALLET"; // Private key of Ashutosh Wallet

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
1
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [
      { version: "0.5.5" },
      { version: "0.5.0" } ,
      { version: "0.6.6" },
      { version: "0.8.8" },
      { version: "0.7.6" } ,
      { version: "0.8.0" } ,
      { version: "0.7.5" } ,
      { version: "0.7.0" } ,
      { version: "0.6.2" }
    ],
    overrides: {
      "@uniswap/v3-periphery/contracts/libraries/PoolAddress.sol": {
        version: "0.6.5",
        settings: { }
      }
    }
  },
  networks: {
    hardhat: {
      forking: {
        url: "https://polygon-mainnet.g.alchemy.com/v2/PF1Ic8rgul5ZkZFUYNZFjak7DwuYHcwd"
        // url: "https://polygon-mainnet.g.alchemy.com/v2/zF-EZv66IP0tcXh9wNv4s6VmxSmW9RMN",
      },
    },
    // avalanche rpc URL for deployment
    avalanche :{
        url : "https://api.avax.network/ext/bc/C/rpc",
        accounts: [`0x${Private_Key}`]
    }
  },
};
