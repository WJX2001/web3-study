// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 库合约的作用：提升代码复用性和减少gas

/** 
  TODO: 库合约与普通合约的不同：
    1. 不能存在状态变量
    2. 不能够继承或被继承
    3. 不能接收以太币
    4. 不可以被销毁
 */
import {Strings} from "./Strings.sol";

contract UseLibrary {
    // 使用using for 指令
    using Strings for uint256;

    function getString1(uint256 _number) public pure returns (string memory) {
        // 库合约中的函数会自动添加为uint256型变量的成员
        return _number.toHexString();
    }

    // 通过库合约名称调用函数
    function getString2(uint256 _number) public pure returns (string memory) {
      return _number.toHexString(_number);
    }
}
