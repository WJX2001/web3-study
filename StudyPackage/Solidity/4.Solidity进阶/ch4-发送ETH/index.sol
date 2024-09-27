// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 接收ETH合约

contract ReceiveETH {
    event Log(uint amount, uint gas);

    // 构造函数
    constructor() payable {
        emit Log(msg.value, gasleft());
    }

    // receive方法
    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    // 返回合约ETH余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

// 发送ETH合约

contract SendETH {
    // 构造函数 payable使得部署的时候可以转eth进去
    constructor() payable {}

    // receive方法
    receive() external payable {}

    // 使用transfer转账
    function transferETH(address payable _to, uint256 amount) external payable {
      _to.transfer(amount);
    }
}
