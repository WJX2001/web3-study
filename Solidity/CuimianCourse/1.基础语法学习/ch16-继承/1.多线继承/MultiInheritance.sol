// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO：多线继承

// 我们要把继承最少的合约放在最前面

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {
    // 这里括号里随便写
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }
}
