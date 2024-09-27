// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


/**
  receive() 函数是合约收到ETH转账时被调用的函数，一个合约最多有一个receive()函数
  receive() 函数不能有任何的参数 ，不能返回任何值，必须包含external和payable
  receive() 最好不要执行太多的逻辑因为如果别人用
    send和transfer方法发送ETH的话,gas会限制2300
    receive太复杂会触发Out of Gas报错
    如果使用call就可以自定义gas执行更复杂的逻辑
 */