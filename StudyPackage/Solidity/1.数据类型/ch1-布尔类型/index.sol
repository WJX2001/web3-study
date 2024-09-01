// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract BoolShortCiruit {
  uint256 public zeroCount = 0;

  function isEven(uint num) private pure returns(bool) {
    return num%2 == 0;
  }

  // isZero 函数有副作用，会改变状态变量zeroCount的值
  function isZero(uint num) private returns(bool) {
    if(num == 0) {
      zeroCount+=1; // 函数副作用 会改变zeroCount的值
    }
    return num == 0;
  }

  bool public _bool1 =  isEven(2) && isZero(0);

}