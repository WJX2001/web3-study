// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Callee {
    event FunctionCalled(string);

    function foo() external payable {
        emit FunctionCalled("this is foo");
    }

    // receive() external payable {
    //     emit FunctionCalled("this is receive");
    // }

    fallback() external payable {
        emit FunctionCalled("this is fallback");
    }
}

contract Caller {
    address payable callee;

    // 部署的时候给Caller合约转账一些Wei,比如100
    // 因为在调用下面的函数时需要用到一些wei

    constructor() payable {
        callee = payable(address(new Callee()));
    }

    // 触发receive函数
    function transferReceive() external {
        callee.transfer(1);
    }

    // 触发receive函数
    function sendReceive() external {
        bool success = callee.send(1);
        require(success, "Failed to send Ether");
    }

    // 触发receive函数
    function callReceive() external {
      (bool success, bytes memory data) = callee.call{value:1}("");
      require(success, "Failed to send Ethe");
    }

    // 触发foo函数
    function callFoo() external {
      (bool success, bytes memory data) = callee.call{value:1}(
        abi.encodeWithSignature("foo()") 
      );
      require(success, "Failed to send Ether");
    }

    // 触发fallback 函数，因为funcNotExist在Callee 没有定义
    function callFallback() external {
      (bool success, bytes memory data) = callee.call{value:1}(
        abi.encodeWithSignature("funcNotExist()")
      );
      require(success, "Failed to send Ether");
    }
}
