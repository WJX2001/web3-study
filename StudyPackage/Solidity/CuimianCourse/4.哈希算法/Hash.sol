// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// 特性：输入值一样 输出值也必须一样

// encode会补0，encodePacked不会补0

contract HashFunc {
    function hash(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes32) {
        // 打包形式 encode 也可以 只是结果不同
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(
        string memory text0,
        string memory text1
    )
        external
        pure
        returns (
            // 不定长类型要加上memory
            bytes memory
        )
    {
        return abi.encode(text0, text1);
    }

    function encodePackaged(
        string memory text0,
        string memory text1
    )
        external
        pure
        returns (
            // 不定长类型要加上memory
            bytes memory
        )
    {
        return abi.encodePacked(text0, text1);
    }

    // 哈希碰撞试验
    // 不同的输入 得到相同的哈希结果
    // 操作方法：第一次输入"AAAB" "BBB" 第二次输入"AAA" "BBBB"

    // 解决方法 隔开一个0
    function collision(
        string memory text0,
        uint x,
        string memory text1
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text0, x, text1));
    }
}
