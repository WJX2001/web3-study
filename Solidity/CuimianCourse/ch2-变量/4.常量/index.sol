// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 将不需要修改的值变成常量

contract Constants {
  // 定义为常量 可以节约gas费 
  address public constant  MY_ADDRESS = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e;
  uint public constant MY_UINT = 123; // 307 gas
}

contract Var {
   address public MY_ADDRESS = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e; // 378 gas 
}