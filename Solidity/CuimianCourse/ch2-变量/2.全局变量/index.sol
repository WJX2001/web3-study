// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract GlobalVariables {
  function globalVars() external view returns(address,uint,uint) {
    // 全局变量 

    // 调用他的地址
    address sender =  msg.sender;
    // 区块的时间戳
    uint timestamp =  block.timestamp;
    // 区块的编号
    uint blockNum =  block.number;

    return (sender, timestamp, blockNum);
  }
}