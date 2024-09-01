// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Payable {
    // 可以发送主币
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 可以接受以太坊主币的传入
    function deposit() external payable {}


    // 显示当前合约的余额
    function getBalance() external view returns (uint) {
      return address(this).balance;
    }
}
