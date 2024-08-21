// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 仅仅能在合约部署的时候调用一次 之后就不能被调用了
// 初始化一些变量
contract Construtor {
  address public owner;
  uint public x;

  constructor(uint _x){
    owner = msg.sender;
    x = _x;
  }
}