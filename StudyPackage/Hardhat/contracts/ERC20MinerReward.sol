// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ERC20MinerReward is ERC20 {
    event LogNewAlert(string description, address indexed _from, uint256 _n);
    constructor() ERC20("MinerReward", "MRW") {}
    function _reward() public {
        // 当前区块的矿工 block.coinbase 会因挖掘该区块获得 20 个 MRW 代币
        _mint(block.coinbase, 20);
        emit LogNewAlert("_rewarded", block.coinbase, block.number);
    }
}
