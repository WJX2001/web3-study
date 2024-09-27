// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/**
  - 所有人都可以存钱
  - 只有合约 owner 才可以取钱
  - 只要取钱，合约就销毁掉 selfdestruct
 */

contract PiggyBank {
    // 状态变量
    address public immutable owner;

    // 存款事件
    event Deposit(address _ads, uint256 amount);
    // 取款事件
    event Withdraw(uint256 amount);

    constructor() payable {
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 取款方法
    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

    // 查询余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
