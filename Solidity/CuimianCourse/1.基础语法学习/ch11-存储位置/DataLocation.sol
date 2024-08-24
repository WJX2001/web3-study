// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

/**
  TODO: 数据存储位置
    storage
    memory
    calldata  // 只能用在输入参数中
 */

contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public MyStructs;

    function examples() external {
        MyStructs[msg.sender] = MyStruct({foo: 1, text: "bar"});

        MyStruct storage myStruct = MyStructs[msg.sender];
        // 此时可以进行读写 并持久保存
        myStruct.text = "foo";
    }

    // 当函数的传入参数是数组的情况下，必须声明在内存中或者calldata
    // 字符串同理，因为字符串本质是一个数组，它是bytes类型的数组
    function examples1(
        uint[] memory y,
        string memory s
    ) external returns (MyStruct memory) {}

    // 如果调用另一个参数
    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }

    // calldata 只能用在参数中，可以节约gas
}
