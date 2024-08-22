// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FunctionOutPuts {
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    // 给返回值一个名字 就可以做到隐式返回
    function assigned() public pure returns (uint x, bool b) {
        // 隐式返回
        x = 1;
        b = true;
    }

    // 调用返回值
    function destructingAssigments() public pure {
        // 类似js中的解构
        (uint x, bool b) = returnMany();
        // 假如只需要其中一个 例如只要第二个 可以用逗号隔离开 可以节省gas
        (, bool _b) = returnMany();
    }
}
