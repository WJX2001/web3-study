// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract TestCall {
    string public message;
    uint public x;
    uint public value = 123;
    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }
    function foo(
        string memory _message,
        uint _x
    ) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 1);
    }
}

contract Call {
    bytes public data;

    // 因为这一次调用发送了主币，合约的本身是没有主币
    function callFoo(address _test) external payable {
        // 调用的合约函数 需要通过编码的形式传入
        /**
    @Param signatureString: 函数名称以字符串的形式传入，参数的名称和存储位置都不需要写
     */
        // 第二个返回值data是bytes类型，用于装载foo函数所有的返回值(带入主币的数量)
        (bool success, bytes memory _data) = _test.call{value: 111}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );

        require(success, "call failed");
        data = _data;
    }

    // 调用不存在的函数
    function callDoesNotExit(address _test) external {
        (bool success, ) = _test.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        require(success, "call failed");
    }
}
