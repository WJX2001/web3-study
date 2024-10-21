// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./FundMe.sol";

// FundMe
// 1. 让FundMe的参与者，基于 mapping 来领取相应数量的凭证
// 2. 让FundMe的参与者，transfer 通证
// 3. 使用完成以后，需要burn通证

contract FundTokenERC20 is ERC20 {
    FundMe fundMe;
    constructor(address fundMeAddr) ERC20("FundTokenERC20","FT"){
        fundMe = FundMe(fundMeAddr);
    }


    function mint(uint256 amountToMint) public {
        require(fundMe.funderToAmount(msg.sender) >= amountToMint, "You cannot mint this many tokens");
        require(fundMe.getFundSuccess(),"The fundme is not completed yet");
        _mint(msg.sender, amountToMint);
        fundMe.setFunderToAmount(msg.sender, fundMe.funderToAmount(msg.sender) - amountToMint);
    }

    function claim(uint256 amountToClaim) public {
        // complete claim
        require(balanceOf(msg.sender) >= amountToClaim, "You dont have enough ERC20 tokens");
        require(fundMe.getFundSuccess(),"The fundme is not completed yet");
        // TODO: 
        // burn amountToClaim
        _burn(msg.sender, amountToClaim);

        
    }

    

}

