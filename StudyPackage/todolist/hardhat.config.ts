import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import 'dotenv/config'

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    hardhat: {},
    sepolia: {
      url: "https://sepolia.infura.io/v3/" + process.env.INFURA_ID,
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  }
};

export default config;

// require("@nomicfoundation/hardhat-toolbox");
// require("dotenv").config();
// console.log(process.env.INFURA_ID,'wjx');
// console.log(process.env.PRIVATE_KEY,'wjx2');
// /** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: "0.8.24",
//   networks: {
//     hardhat: {},
//     sepolia: {
//       url: "https://sepolia.infura.io/v3/" + process.env.INFURA_ID,
//       accounts: [`0x${process.env.PRIVATE_KEY}`],
//     },
//   },
// };
