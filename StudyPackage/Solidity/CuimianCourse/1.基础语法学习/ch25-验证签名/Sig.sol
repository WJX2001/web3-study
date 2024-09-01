// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 验证签名

/**
  1. 将消息进行签名
  2. 将消息进行哈希值
  3. 把消息和私钥进行签名（链下）
  4. 恢复签名
 */

contract VerifySig {
    function verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    // 哈希运算函数
    function getMessageHash(
        string memory _message
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    // 再进行一次哈希运算
    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        // 这里需要增加一个字符串 因为是在链下进行操作
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    // 恢复函数
    function recover(
        bytes32 _ethSignedMessageHash,
        bytes memory _sig
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        // 内部函数
        // vrs 都是签名的组成部分
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(
        bytes memory _sig
    ) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
      // 32+32+1 = 65
        require(_sig.length == 65, "invalid signature length");
        // 内联汇编
        // 签名的原理就是rsv三个元素拼接出来的
        // mload 是内存中读取的方法
        // add 加上签名 加上 32 来跳过：32代表跳过32位，来获取32位之后的32位
        // 64是因为 r占了32 再往后取32位
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
