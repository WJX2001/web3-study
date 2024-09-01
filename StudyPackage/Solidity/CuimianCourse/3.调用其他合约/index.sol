// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 调用其他合约

contract CallTestContract {
    function setX(address _test, uint _x) external {
        // 另一个合约的地址
        // TODO: 调用其他合约的方法,将另一个合约当作类型，传入地址，然后调用函数
        TestContract(_test).setX(_x);
    }

    // 第二种写法
    function setX2(TestContract _test, uint _x) external {
        // 直接将调用的合约作为类型，然后再调用
        _test.setX(_x);
    }

    function getX(address _test) external view returns (uint) {
        // TODO: 获取另一个合约的变量
        return TestContract(_test).getX();
    }

    function setXandSendEther(address _test, uint _x) external payable {
        // 把这次发送的所有主币 传入过去
        TestContract(_test).setXandReceiveEther{value: msg.value}(_x); // 主币如何传入
    }

    function getXAndValue(
        address _test
    ) external view returns (uint x, uint value) {
        // TODO: 获取另一个合约的变量
        (x, value) = TestContract(_test).getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    // 设置一个变量的时候，同时传递进去主币
    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value; // 接收到主币发送的数量
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}
