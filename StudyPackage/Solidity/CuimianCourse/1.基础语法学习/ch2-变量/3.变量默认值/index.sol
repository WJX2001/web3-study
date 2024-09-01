// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract DefaultValues {
  bool public b; // false 
  uint public u; // 0 
  int public i; // 0
  // 0地址 20位16进制数字 40个0 每一位两个
  address public a; // 0x0000000000000000000000000000000000000000
  bytes32 public b32; // 0x0000000000000000000000000000000000000000000000000000000000000000
}