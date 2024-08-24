// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// TODO: 删除谁 就将最后一个元素进行替换 然后 把最后一个进行pop掉
// 这样更节省gas 但是数组顺序 会被修改

contract ArrayReplaceLast {
    uint[] public arr;

    function remove(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4];
        remove(1);

        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);
    }
}
