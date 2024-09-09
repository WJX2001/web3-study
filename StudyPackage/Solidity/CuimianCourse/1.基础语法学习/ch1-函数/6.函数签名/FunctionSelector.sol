// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 写一个获取函数选择器的合约
// 测试参数："transfer(address,uint256)"
// 测试结果  0xa9059cbb
contract FunctionSelector {
  function getSelector(string calldata _func) external pure returns (bytes4) {
    return bytes4(keccak256(bytes(_func)));
  }
}


contract Receive {
  event Log(bytes data);

  function transfer(address _to, uint _amount) external {
    emit Log(msg.data);
    // 0xa9059cbb
    // 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
    // 000000000000000000000000000000000000000000000000000000000000000b
  }

}