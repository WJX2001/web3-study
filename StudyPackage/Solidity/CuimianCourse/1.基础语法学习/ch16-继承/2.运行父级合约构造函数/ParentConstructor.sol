// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 运行父级合约构造函数

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// TODO: 写法一
contract U is S("wjx"), T("t") {
    // 输入构造函数参数
}

// TODO: 写法二
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// TODO: 混合写法
contract VV is S("ss"), T {
    constructor(string memory _text) T(_text) {}
}

