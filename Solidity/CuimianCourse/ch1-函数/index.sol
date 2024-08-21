// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract FunctionIntro {
    // external 表示外部函数 只能在外部读取的函数
    // pure 表示纯函数：表示这个函数，不能读也不能写状态变量，只能够拥有局部变量，不对链上有任何的读写操作
    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function sub(uint x,uint y) external pure returns (uint) {
      return x - y;
    }
    
}
