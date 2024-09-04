// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 多签钱包 只有当多个人同意的时候，才会将合约的主币向外转出

contract MultiSigWallet {
    // TODO: 事件
    // 存款事件
    event Deposit(address indexed sender, uint amount);
    // 提交一个交易的申请
    event Submit(uint indexed txId);
    // 合约的签名人进行批准(合约中有多个签名人，需要多次批准)
    event Approve(address indexed owner, uint indexed txId);
    // 撤销批准(交易没有被提交前可以撤销)
    event Revoke(address indexed owner, uint indexed txId);
    // 执行交易 (合约中的主币就可以传输出来了到另一个地址)
    event Execute(uint indexed txId);

    // TODO: 结构体
    // 创建交易的结构体(保存着每一个发出主币的交易数据)
    // 这次交易由一个签名人发起 由其他签名人去同意通过
    struct Transaction {
        address to; // 目标地址
        uint value; // 交易数量
        bytes data; // 如果目标地址是一个合约地址，还可以执行目标地址中的函数
        bool executed; // 是否被执行了
    }

    // TODO: 变量
    // 合约的拥有者 （多个签名人 有多个）
    address[] public owners;
    mapping(address => bool) public isOwner; // 数组中不能进行快速查找，我们在查找数组中是否有某一个地址，需要循环，浪费gas
    uint public required; // 不管合约中有多少人，最少需要满足确认数的签名人同意，钱包中的交易才能被批准

    Transaction[] public transactions; // 记录所有的交易
    mapping(uint => mapping(address => bool)) public approved; // 交易id号 ==> 一个地址 ==> 一个布尔值 用来某一个签名人的地址是否批准了这个交易

    // TODO: 修改器

    // 签名人合法判断
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    // 交易号是否存在
    modifier txExists(uint _txId) {
        // 当小于数组长度 证明交易是存在的
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    // 证明没有被批准过 (txId代表交易ID)
    // 某一个id之下，某一个签名人是否已经批准
    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    // 证明没有被执行过
    modifier notExecuted(uint _txId) {
        // 因为数组中存着交易信息 交易信息是一个对象 其中有个executed属性
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    // TODO: 构造函数
    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(
            _required > 0 && _required <= _owners.length,
            "Invalid required number"
        );

        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];
            // 首先不等于0地址
            require(owner != address(0), "invalid owner");
            // 这个地址不能是已经被添加过的地址
            require(!isOwner[owner], "owner is not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    // TODO: 方法函数实现
    // 收款方法
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 提交交易方法
    function submit(
        address _to,
        uint _value,
        bytes calldata _data
    ) external onlyOwner {
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );
        emit Submit(transactions.length - 1);
    }

    // 批准方法(交易号要存在 没批准过的 没被执行过的)
    function approve(
        uint _txId
    ) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    // 计算一下某个交易id之下的签名人之下有多少人批准了
    // 获取批准数量
    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for (uint i; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1; // 隐式返回
            }
        }
    }

    // 执行 方法
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        // 判断确认数 是否大于等于最小确认数
        require(_getApprovalCount(_txId) >= required, "approvals < required");

        // 提取交易
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true; // 这样不能再次被执行

        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );

        require(success, "tx failed");
        emit Execute(_txId);
    }

    // 允许签名人在一笔交易没有执行前 可以撤销
    function revoke(
        uint _txId
    ) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
