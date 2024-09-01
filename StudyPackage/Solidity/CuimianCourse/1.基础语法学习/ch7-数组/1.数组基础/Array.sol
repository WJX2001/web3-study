// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Array {
    // 动态数组
    uint[] public nums = [1, 2, 3];
    // 定长数组
    uint[3] public numsFixed = [4, 5, 6];

    function examples() external {
        // 增
        nums.push(4); // [1,2,3,4]
        // 查
        uint x = nums[1];
        // 改
        nums[2] = 777; // [1,2,777,4]
        // 删除(删除不会修改数组的长度，所以将删除位置的元素变为默认值0)
        delete nums[1]; // [1,0,777,4]
        // 弹出
        nums.pop(); // [1,0,777]
        // 长度
        uint len = nums.length;

        // 创造数组在内存中 create array in memory
        // ! 在内存中不能创建动态数组，所以必须要定长 
        // ! 同理：不能使用pop push 方法，因为会改变数组的长度
        uint[] memory a = new uint[](5);
    }

    // 返回数组中的全部内容 数组是内存的返回类型
    function returnArray() external view returns (uint[] memory) {
      return nums;
    }
}
