// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 我们将一些常用的算法 抽象成库合约，避免大量代码编写
// 一般在合约内部使用

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for (uint i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    // 数组拥有了库函数的所有功能
    using ArrayLib for uint[];
    uint[] public arr = [3, 2, 1];

    function testFind() external view returns (uint i) {
        // return ArrayLib.find(arr, 1);
        return arr.find(1);
    }
}
