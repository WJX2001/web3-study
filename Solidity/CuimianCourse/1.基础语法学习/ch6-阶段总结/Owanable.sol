// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Ownable合约
contract Ownable {
  address public owner;

  constructor() {
    // 合约的部署者
    owner = msg.sender;
  }

  // 函数修改器
  modifier onlyOwner() {
    require(msg.sender == owner,"not owner");
    _;
  }

  // 设置新的合约所有者
  function setOwner(address _newOwner) external onlyOwner {
    // 地址不能是0地址，否则合约的所有权被锁死
    require(_newOwner != address(0),"invalid address");
    owner = _newOwner;
  }
  
  
  function onlyOwnercanCallThisFunc() external onlyOwner {
    // 
  }

  function anyOneCanCall() external {
    // code
  }
}