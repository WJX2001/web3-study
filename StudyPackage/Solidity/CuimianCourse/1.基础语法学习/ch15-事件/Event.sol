// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 事件
/** 
  事件是一种记录当前智能合约运行状态的方法，并不记录在状态变量中
 */
contract Event {
    event Log(string message, uint val);
    // 在类型之后规定一个索引，indexed，在链外进行查询
    // up to 3 index
    // 一个事件中只能定义不超过3个的索引变量
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        // 函数调用的时候 会触发
        emit Log("foo", 123);
        // 可以进行数据检索
        emit IndexedLog(msg.sender, 789);
    }
    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
