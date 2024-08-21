// TODO: 字面值
// 指在程序中无需变量保存，可以直接表示为一个具体的数字或字符串的值
/**
  1. 地址字面值
  2. 有理数和整数字面值
  3. 字符串字面值
  4. Unicode字面值
 */

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract C {
    // TODO: 地址字面值
    // 长度为42字节的十六进制的字符串形如
    // 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990 就是一个地址字面值。地址字面值可以直接赋值给地址类型：

    address addr = 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990;

    // TODO: 有理数和整数字面值
    /**
      1. 十进制整数：123
      2. 十进制小数：.1 1.2 但是不能是1. 限制小数点后面必须至少跟一个数字
      3. 十六进制数：例如0xff
      4. 科学计数法: 2e10 
     */

     uint256 d1 = 123;
     uint256 d2 = .1+1.9;
     uint256 h = 0xff;
     int256 s1 = 2e10;
     int256 s2 = -2e10;
     // ! Solidity不支持8进制字面值

     uint256 public p = (2**800+1) - 2**800;

    // TODO: 隐式类型转换
    bytes1 b1 = "b";
    string public a = unicode"Hello \u0041 😃";

    
}   
