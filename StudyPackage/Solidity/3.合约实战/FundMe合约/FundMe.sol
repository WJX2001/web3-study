// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
/**
 * Get funds from users
 * Withdraw funds
 * Set a minimum funding value in USD
 */

import "./PriceConverter.sol";

// constant Immutable

error NotOwner();


contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Want to be able to set a minimum amount in USD
        // 1. How do we send ETH to this contract?
        // 至少需要转1个ETH 10的 18次方 WEI
        // 需要先将msg.value从ETH转换为等价值的美元
        require(
            msg.value.getConversionRate() > MINIMUM_USD,
            "Didn't send enough"
        );
        // 18 decimals

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // actually withdraw the founds

        // transfer
        // send
        // call

        // msg.sennder = adress
        // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    // What happens if someone sends this contract ETH without calling the fund function

    // receive 和 fallback
    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
    
}
