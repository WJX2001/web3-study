// TODO: 地址字面值

// 长度为42字节的十六进制的字符串形如
// 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990 就是一个地址字面值。地址字面值可以直接赋值给地址类型：

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract C {
  address addr = 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990;
}