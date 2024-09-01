// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 自毁合约
// - delete contract 删除合约
// - force 发送主币到一个地址

contract Kill {
    // 在构造函数中将主币传到函数中，让合约储存下来主币，这样合约自毁的时候，主币就会返还给我们
    constructor() payable {}

    function kill() external {
        // 发送到消息的调用者(强制行为)
        // 将合约剩余的主币强制发送到合约上，合约强制接受我们发送的主币
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}
