// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ArraySlicing {
    // 截取字符串前4bytes的示例
    function extracFourBytes(
        string calldata payload
    ) public view returns (string memory) {
        string memory leading4Bytes = string(payload[:4]);
        return leading4Bytes;
    }

    // TODO: 数组切片只能作用于calldata
    uint[5] storageArr = [uint(0), 1, 2, 3, 4];
    
}
