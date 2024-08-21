// TODO: 数组
// 数组分为静态数组和动态数组

// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ArrayDemo {
    function test() public view {
        // 声明静态数组
         uint[3] storage nftStorage;

        // 动态数组
        uint[] memory nftMem;
        uint[] storage nftStorage1;

        // 数组字面值初始化
        // 且长度必须跟数组字面值保持一致
        uint[3] memory nftArr = [uint(1000),1001,1002];

        // TODO: 动态数组初始化
        uint n = 3;
        uint[] memory nftArr2 = new uint[](n);

        // TODO: 数组赋值
        nftArr2[0] = 1000;
        nftArr2[1] = 1001;
        nftArr2[2] = 1002;

        // 动态数组只有在storage位置才能用数组字面值初始化
        
    }
}
