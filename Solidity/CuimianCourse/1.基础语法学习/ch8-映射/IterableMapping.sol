// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 映射迭代
contract IteravbleMapping {
    // 映射不能遍历
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint _val) external {
        // 首先设置余额
        balances[_key] = _val;

        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function first() external view returns (uint) {
        return balances[keys[0]];
    }

    function last() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    // 获得任意索引
    function get(uint _index) external view returns (uint) {
        return balances[keys[_index]];
    }
}
