// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 测试合约一
contract TestContract1 {
    address public owner = msg.sender;

    // 设置管理员
    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}

// TODO: 测试合约二
contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    // TODO: 这个事件 向链外汇报新部署合约的地址
    event Deploy(address);
    // payable可以发送主币 同时返回新部署的地址

    function deploy(
        bytes memory _code
    ) external payable returns (address addr) {
        // 这里returns 里面写了addr 所以可以隐式返回
        // TODO: 内联汇编
        assembly {
            // create(v,p,n)
            // v: 部署合约发送以太坊主币的数量
            // p: 内存中机器码开始的位置
            // n: 内存中机器码的大小

            // add 跳过0x20这个位置
            /* 为什么跳过0x20这个位置，因为
                solidity中在内存中的存储结构是前32字节，存储了bytes数据的长度，也就是0x20字节
                所以需要跳过这个长度，后面的才是真正存储的字节码数据
             */
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }

        // 这里部署不一定成功，所以确认一下返回的地址不是0地址
        require(addr != address(0), "deploy failed");

        // TODO: 向链外汇报addr这个地址,这样可以在交易详情中看到这个地址
        emit Deploy(addr);
    }

    // TODO: 将合约的管理者改成我们自己 执行方法
    function execute(address _target, bytes memory _data) external payable {
        // 我们要设置目标地址和传入参数

        (bool success, ) = _target.call{value: msg.value}(_data);
    }
}

// TODO: 助手合约
//
contract Helper {
    // TODO: 测试合约一的帮助函数 获取机器码
    function getBytecode1() external pure returns (bytes memory) {
        // type 得到部署合约所需要的机器码
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode; // 将这个bytecode输入到代理合约中 代理合约就可以把合约部署上了
    }

    // TODO: 测试合约二的帮助函数
    function getBytecode2(
        uint _x,
        uint _y
    ) external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    // TODO: 
    function getCalldata(address _owner) external pure returns (bytes memory) {
      // 调用设置管理员的方法
      return abi.encodeWithSignature(
        "setOwner(address)", _owner);
    }
}
