// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract StateVariables {
  // 这个永远记录在链上
  uint public myUint = 123;

  function foo() external {
    uint notStateVariable = 456;
  }
}