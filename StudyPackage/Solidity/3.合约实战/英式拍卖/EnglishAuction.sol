// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

interface IERC721 {
    function transferFrom(address from, address to, uint nftId) external;
}

contract EnglishAuction {
    event Strat();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address hightestBidder, uint amount);

    // 只能拍卖一个nftId，如想多个，需要
    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller; // 销售者
    uint32 public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    uint public hightestBid;
    mapping(address => uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid // 起拍价格
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        hightestBid = _startingBid;
    }

    function start() external {
        // 拍卖者和销售者保持一致
        require(msg.sender == seller, "not seller");
        require(!started, "already started");

        started = true;
        endAt = uint32(block.timestamp + 60); // 60秒结束
        nft.transferFrom(seller, address(this), nftId);
        emit Strat();
    }

    // 拍卖的函数方法
    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > hightestBid, "value < hightest big");

        if (highestBidder != address(0)) {
            bids[highestBidder] += hightestBid;
        }

        hightestBid = msg.value; // 将最高价替换
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    // 有新的最高出价 需要进行撤回上次的金额
    function withdraw() external {
        // 拿到当前金额数量
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    // 结束拍卖(任何人都可以调用)
    function end() external {
        // 处于一个已经开始，但是还没结束的状态
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");

        ended = true;
        if (highestBidder != address(0)) {
            // 将合约中保存的nft发送到接受者的地址
            nft.transferFrom(address(this), highestBidder, nftId);
            // 将合约中的主币发送到销售者的地址上
            seller.transfer(hightestBid);
        } else {
            // 将nft退还给销售者
            nft.transferFrom(address(this), seller, nftId);
        }

        emit End(highestBidder, hightestBid);
    }
}
