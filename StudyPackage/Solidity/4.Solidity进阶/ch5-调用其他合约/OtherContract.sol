// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract OtherContract {
    uint256 private _x = 0; // 状态变量_x
    // 收到eth的事件，记录amount和gas
    event Log(uint amount, uint gas);

    // 返回合约ETH余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable {
        _x = x;
        // 如果转入ETH，则释放Log事件
        if (msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取_x
    function getX() external view returns (uint x) {
        x = _x;
    }
}

contract CallContract {
    function callSetX(address _Address, uint256 x) external {
        OtherContract(_Address).setX(x);
    }

    // 传入合约变量
    // 直接传入合约的引用，把上面参数的address类型改为目标合约名
    // 函数参数OtherContract _Address底层仍然受address
    function callGetX(OtherContract _Address) external view returns (uint x) {
        x = _Address.getX();
    }

    // 创建合约变量
    function callGetxX2(address _Address) external view returns (uint x) {
        OtherContract oc = OtherContract(_Address);
        x = oc.getX();
    }

    // 调用合约并发送ETH
    function setXTransferETH(
        address otherContract,
        uint256 x
    ) external payable {
        OtherContract(otherContract).setX{value: msg.value}(x);
    }
}
