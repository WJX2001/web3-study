// TODO: 整型

/**
  整型有两种：
    1. intM：有符号整型
    2. uintM: 无符号整型
    M：范围为8-256，步长伟8
    int8/uint8 占8bits， int16/uint16 占16bits
 */


// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract IntType {
    uint256 public a = 5;
    uint256 public b = 2;
    // TODO: 算数运算符
    // 次方运算符 ** 只支持无符号整数类型 (uint256)，不支持有符号整数类型 (int256)
    uint256 public tmp = a**b;

    // << 相当于 乘以移动2的移动位数的次方
    // >> 相当于 除以移动2的移动位数的次方
    uint256 public tmp1 = a << b;
    uint256 public tmp2= a >> b;

    // TODO: 位运算符
    // & 按位与：只有两个位都是1，结果才是1
    // | 按位或: 任意一个位是1，结果就是1
    // ^ 按位异或：相应的位不同是1，相同为0
    // ~ 按位取反：取反，1变0，0变1

    uint8 c = 5;
    uint8 d = 2;

    // 0000 0101 c
    // 0000 0010 d
    uint8 bitwisAnd = c & d; // 0
    uint8 bitwisOr = c | d; // 7
    uint bitwisXor = c ^ d; // 7
    // 0000 0101 
    // 1111 1010
    uint8 bitwisNot = ~c; // 250
    
    // // 整型溢出
    // function overflow() public returns (uint8){
    //     uint8 a = 254;
    //     a = a+1; //整型溢出，整个transaction revert
    //     // console.log("a=%s", a);
    //     return a;
    // }

     function overflow() public pure returns (uint8) {
        uint8 m = 25;
        // unchecked {
        //     a = a + 1; // 整型溢出，不会触发 revert
        // }
         m= m + 1; // 整型溢出，不会触发 revert
        return m; // 返回溢出的值
    }


}
