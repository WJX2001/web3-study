// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 继承 让两个条约能拥有父亲的功能

// virtual表示可以重写
contract A {
    // virtual 表示可以重写
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function baz() public pure returns (string memory) {
        return "A";
    }
}

// 表示继承
contract B is A {
    // override 覆盖的含义
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B {
    function bar() public pure override returns (string memory) {
        return "C";
    }
}
