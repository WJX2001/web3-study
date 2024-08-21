// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ForAndWhileLoops {
    function loops() external pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            // more code
            break;
        }

        // 通过break 跳出
        while (true) {
            // more code
            break;
        }
    }

    // 合约中不能让n太大 会造成gas费太多，所以需要控制循环数量
    function sum(uint n) external pure returns (uint) {
        uint s;
        for (uint i = 1; i <= n; i++) {
            s += i;
        }
        return s;
    }
}
