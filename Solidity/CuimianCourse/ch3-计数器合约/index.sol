// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Counter {
  // public 内部和外部都可以读取这个变量的值
  uint public count;
  
  // TODO: 可视范围：外部可视的含义 合约的内部的其他函数 是不能调用的 只能通过外部读取
  // 因为这个函数是写入方法 所以不能有view 和 pure的关键词
  function inc() external {
    count +=1;
  }

  function dec() external {
    count -=1;
  }
  
  
}