// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract CrowdFunding {
    address public immutable beneficiary; // 受益人
    uint256 public immutable fundingGoal; // 筹资目标数量
    uint256 public fundingAmount; // 当前的 金额
    mapping(address => uint256) public funders; // 资助者地址和金额
    // 可迭代的映射
    mapping(address => bool) private fundersInserted;
    address[] public fundersKey; // length
    // 不用自销毁方法，使用变量来控制
    bool public AVAILABLED = true; // 状态
    // 部署的时候，写入受益人+筹资目标数量
    constructor(address beneficiary_, uint256 goal_) {
        beneficiary = beneficiary_;
        fundingGoal = goal_;
    }

    /**
     * 资助操作
     *   可用的时候才可以捐款
     *   合约关闭之后，就不能再进行捐助
     */

    function contribute() external payable {
        require(AVAILABLED, "CrowdFunding is closed");

        // 检查捐赠金额是否会超过目标金额
        uint256 potentialFundingAmount = fundingAmount + msg.value;
        uint256 refundAmount = 0;

        if (potentialFundingAmount > fundingGoal) {
            // 需要退回的金额
            refundAmount = potentialFundingAmount - fundingGoal;
            funders[msg.sender] += (msg.value - refundAmount);
            // 更新当前金额
            fundingAmount += (msg.value - refundAmount);
        } else {
            funders[msg.sender] += msg.value;
            // 更新当前总金额
            fundingAmount += msg.value;
        }

        // 更新捐赠者信息
        if (!fundersInserted[msg.sender]) {
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        // 退还多余的金额
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }

    // 关闭
    function close() external returns (bool) {
        // 1. 检查
        if (fundingAmount < fundingGoal) {
            return false;
        }

        uint256 amount = fundingAmount;
        // 2.修改
        fundingAmount = 0;
        AVAILABLED = false;

        // 3. 操作
        payable(beneficiary).transfer(amount);
        return true;
    }

    function fundersLenght() public view returns (uint256) {
        return fundersKey.length;
    }
}
