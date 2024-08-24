// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 报错处理
/**
  1、require、revert、assert 都具有gas费用的退还
  2、状态变量回滚
  3、8版本后 自定义的error控制 - save gas
 */

contract Error {
    function testRequire(uint _i) public pure {
        // 只有满足前面的条件为真 才能运行后面的代码
        require(_i <= 10, "i must > 10");
    }

    function testRevert(uint _i) public pure {
        // revert 必须依赖if语句
        if (_i > 10) {
            revert("i must <= 10");
        }
    }

    uint public num = 10;

    // 断言的含义
    function testAssert() public view {
        // assert 没有条件限制
        assert(num == 123);
    }

    function foo(uint _i) public {
        num += 1;
        require(_i < 10); // 一旦触发此条件 状态会被回滚 gas费用也会被退还
    }

    error MyError(address caller, uint i);

    function testcustomError(uint _i) public view {
        if (_i > 10) {
            revert MyError(msg.sender, _i);
        }
    }
}
