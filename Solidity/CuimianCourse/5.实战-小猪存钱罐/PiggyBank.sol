// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 可以通过任何人的地址向合约发送以太坊主币
// 存钱罐拥有者才可以取钱，取出之后合约会自毁

contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);
    address public owner = msg.sender;

    receive() external payable {
      emit Deposit(msg.value);
    }

    // 取款方法
    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        emit Withdraw(address(this).balance);
        // 1.将合约上的主币发送给合约的拥有者
        // 2.进行销毁
        selfdestruct(payable(msg.sender));
    }
}
