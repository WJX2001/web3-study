// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
  地址分为两类：
    1. address：普通地址类型（不可接收转账）
    2. address payable: 可收款地址类型（可接收转账）
 */

/** 
   Solidity的账户分为两种：
      外部账户： EOA
        其中 EOA 就是我们平常在 MetaMask 上创建的那些账户
      合约账户： CA
        合约账户则是在部署合约完成后返回的合约账户地址
 */

contract AddressType {
    address addr = 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990;
    address payable addr_pay =
        payable(0x8306300ffd616049FD7e4b0354a64Da835c1A81C);

    // TODO: 成员变量
    /**
      1、balance: 账户余额 单位是Wei
      2、code: 该地址的合约代码，EOA为空，CA账户为非空
      3、codehash: 该地址的合约代码hash 
     */

    function get_balance() public view returns (uint256) {
        return address(this).balance; // 获取地址账户余额
    }

    function get_code() public view returns (bytes memory) {
        return address(this).code; //获取合约代码
    }

    function get_codehash() public view returns (bytes32) {
        return address(this).codehash; //获取合约代码的hash值
    }
}
