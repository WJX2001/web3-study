// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 回退函数

contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    // 回退函数 可以接受主币的发送 ( 备用函数 )
    // TODO: 接受合约中不存在的合约调用
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    // 第二种写法（只接受主币 8.0之后版本）不接受任何数据
    receive() external payable {
        emit Log("fallback", msg.sender, msg.value, "");
    }
}
