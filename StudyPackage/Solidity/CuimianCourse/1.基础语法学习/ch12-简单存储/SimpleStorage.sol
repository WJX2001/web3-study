// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage {
    string public text;

    // external：合约内部其他函数 不能调用此函数

    // calldata 89626 gas
    // memory 90114 gas

    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns (string memory) {
        return text;
    }
}
