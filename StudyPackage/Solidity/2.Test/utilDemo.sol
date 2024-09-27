// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 定义一个Utils合约 其中有sum方法，传入任意数量的数组，都可以计算出求和结果

contract Utils {
    function sum(uint256[][] memory numbers) public pure returns (uint256) {
        uint256 total = 0;

        for (uint256 i = 0; i < numbers.length; i++) {
            for (uint256 j = 0; j < numbers[i].length; j++) {
                total += numbers[i][j];
            }
        }

        return total;
    }
}