// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Immutable {
    // 一次定义成功 变成常量 节约gas
    // 必须在合约部署的时候定义，才能像常量一样工作
    address immutable owner;

    constructor() {
      owner = msg.sender;
    }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}
