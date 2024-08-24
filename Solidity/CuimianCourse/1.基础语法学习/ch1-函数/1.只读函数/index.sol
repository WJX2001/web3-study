// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

contract ViewAndPureFunctions {
    uint public num;

    // view 关键词 读取了num状态变量
    function viewFunc() external view returns (uint) {
        return num;
    }

    // pure 关键字 不能读取链上的信息
    function viewFunc1() external pure returns (uint) {
        // return num;
        return 1;
    }

    // 这里用view的原因 是读取了 num状态变量
    function addToNum(uint x) external view returns (uint) {
        return num + x;
    }

    // 这里使用pure的原因 是没有读取链上信息 所以是纯函数
    function add(uint x,uint y) external pure returns (uint) {
        return x+y;
    }
}
