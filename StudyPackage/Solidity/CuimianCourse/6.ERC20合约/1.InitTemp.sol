// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 合约接口

interface IERC20 {
    // 当前合约的token总量
    function totalSupply() external view returns (uint);

    // 某一个账户的当前余额
    function balanceOf(address account) external view returns (uint);

    // 把账户的余额由当前调用者发送到另一个账户中
    // 会向链外汇报一个标准的transfer事件，通过transfer事件能查询到token的流转
    function transfer(address recipient, uint amount) external returns (bool);

    // 查询某一个账户对另一个账户的批准额度有多少
    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    // 把我账户中的数量批准给另一个账户
    function approve(address spender, uint amount) external returns (bool);

    // 向另一个合约存款的时候，另一个合约必须调用transferFrom方法，
    // 才能把我们账户中的token拿到他的合约中
    function transferFrom(
        address spender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

// 合约实现
contract ERC20 is IERC20 {
    // 标明当前合约的token总量
    uint public override totalSupply;
    // 账本
    mapping(address => uint) public override balanceOf;
    // 被批准的地址
    mapping(address => mapping(address => uint)) public override allowance;
    string public name = "Test";

    // token的缩写
    string public symbol = "TEST";
    // token的精度 一个整数1后面会有18个0的小数
    // 0.5个token如何记录：1个6后面再加17个0
    // 1个1 18个0 代表整数1
    uint8 public decimals = 18;

    function transfer(
        address recipient,
        uint amount
    ) external override returns (bool) {
        // 发送者账户减掉一个数量 接受者账户增加一个数量
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // 批准方法
    function approve(
        address spender,
        uint amount
    ) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        // 给发送者对应被批准账户（当前消息调用者）（额度就没有了）
        allowance[sender][msg.sender] -= amount;
        // 这里是从发送的账户中减掉余额，而不是消息调用者 因为消息调用者只是减去调用额度
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // 铸币方法
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        // 0地址发送的token
        emit Transfer(address(0), msg.sender, amount);
    }

    // 销毁方法
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
