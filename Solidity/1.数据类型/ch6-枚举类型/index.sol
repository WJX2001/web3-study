// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Enumtype {

  enum ActionChoices {
    GoLeft,     // 底层表示为 0 
    GoRight,    // 底层表示为 1
    GoUp,       // 底层表示为 2
    GoDown      // 底层表示为 3
  }

  ActionChoices public choice = ActionChoices.GoDown;
  
  // TODO: 枚举类型作为函数参数返回值
  ActionChoices choice1;

  function getChoice() public view returns (ActionChoices) {
    return choice1;
  }
  
  

}

