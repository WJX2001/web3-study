// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 函数修改器：能够使复用的代码进行简化
// Basic，inputs，sandwich

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    // TODO: Basic 写法
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; // _代表其他代码在哪里运行
    }

    function inc() external whenNotPaused {
        count += 1;
    }

    function dec() external whenNotPaused {
        count -= 1;
    }

    modifier cap(uint _x) {
        require(_x < 100, "x >=100");
        _;
    }

    // TODO: Input写法
    // 分步进入 修改器
    function incBy(uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    // TODO: Sandwich写法
    modifier sandwich() {
        count += 10;
        _;
        count *= 2;
    }

    function foo() external sandwich {
        count += 1;
    }
}
