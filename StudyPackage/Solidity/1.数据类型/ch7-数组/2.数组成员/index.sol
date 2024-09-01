// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract Array {
  
  // function memberArray() public returns (string memory){

  //   //TODO:  成员变量 
  //   // 正常成员变量只有一个length
  //   uint[3] memory arr1 = [uint(1000),1001,1002];
  //   uint[] memory arr2 = new uint[](3);

    
  // }

  // 动态数组成员函数
    // TODO: 只有动态数组，并且其数据位置为storage的时候才有成员函数，其他数组，比如静态数组，在calldata,memory的数组是没有成员函数的
    
    uint[] public arr; // 定义在storage位置的数组
    
    function pushPop() public {
      // 刚开始没有任何元素
      arr.push(); //
      arr.push(100);
    }
}