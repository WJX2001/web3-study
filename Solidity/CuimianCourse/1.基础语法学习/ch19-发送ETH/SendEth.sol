// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 发送ETH 有三种方法

// transfer - 2300gas reverts
// send - 2300gas bool
// call - all gas returns bool and data 带有所有的gas 



contract SendEther {
  // 传入主币
  constructor() payable {}
  
  receive() external payable {}
  
  function sendViaTransfer(address payable _to) external payable {
    _to.transfer(123); // 发送123wei 带着2300gas
  }

  function sendViaSend(address payable _to) external payable {
    bool sent = _to.send(12);
    require(sent,"sent failed");
  }

  function sendViaCall(address payable _to) external payable {
    (bool success,) = _to.call{value: msg.value}("");
    require(success, "call failed");
  }
}

// 接受主币发送 上面为发送 下民接受
contract EthReceiver {
  event Log(uint amount, uint gas);

  receive() external payable {
    emit Log(msg.value, gasleft());
  }
}

