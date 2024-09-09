// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 随着时间的流逝，这个商品的价格会逐渐的降低，直到有人举牌的时候，拍卖结束

interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftid) external;
}

contract DutchAuction {
    uint private constant DURATION = 7 days;

    // 定义nft合约变量
    IERC721 public immutable nft; // 这是我们要拍卖的合约
    uint public immutable nftId;

    // 销售者的地址 由持有者的地址拍卖出去
    address payable public immutable seller;
    // 起拍价
    uint public immutable startingprice;
    // 开始时间
    uint public immutable startAt;
    // 过期时间(超过这个时间，这次拍卖不成功)
    uint public immutable expiresAt;
    // 每秒的折扣率
    uint public immutable discountRate;

    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ) {
        // 销售成功的时候，要把主币发送给销售者
        seller = payable(msg.sender);
        startingprice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;

        // 确认拍卖的时候，价格每秒都在减少，但是不能减少到负数
        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingprice - discount;
    }

    // 购买逻辑
    function buy() external payable {
        require(block.timestamp < expiresAt, "auction expired");
        uint price = getPrice();
        // 主币数量必须大于等于刚才的拍卖价格
        require(msg.value >= price, "ETH < price");
        // 从拍卖者的账户中 发送到这次合约的消息调用者
        nft.transferFrom(seller, msg.sender, nftId);
        // 很难保证购买者从他发送交易开始，到区块确认成功，这个价格不发生变化
        // 定义一个退款金额
        // 目的：用户购买者发送过来的数量可能大于我们nft的的价格
        uint refund = msg.value - price
        if(refund > 0) {
          payable(msg.sender).transfer(refund);
        }

        // 退款金额退回购买者的账户之后，将这次拍卖的销售所得的主币数量发送到出售者的账户中
        // 销售拍卖合约自毁方法
        // 不仅能将合约上剩余的主币发送给销售者的账户中，
        // 还能将合约部署所占用的空间消耗的gas退还给销售者的账户中
        selfdestruct(seller);
    }
}
