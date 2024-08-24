// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 映射

/**
  当想在数组中想找到某个元素是否存在，需要遍历整个数组，浪费很多的gas，所以引入了映射
 */

 contract Mapping {
  // 地址对应uint
  mapping(address => uint) public balances;
  mapping(address => mapping(address => bool)) public isFriend;

  function examples() external {
    balances[msg.sender] = 123;
    uint bal =  balances[msg.sender]; 

    // 给一个不存在的映射
    uint bal2 = balances[address(1)]; // 0
    
    // 123+456
    balances[msg.sender] += 456; // 579

    // 删除数据
    delete balances[msg.sender]; // 0
    isFriend[msg.sender][address(this)]; // 第一个是调用者 第二个参数是合约地址
  }

 }