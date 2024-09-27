// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Demo {
    struct Todo {
        string name;
        bool isCompleted;
    }

    Todo[] public list;

    // 创建任务
    function create(string memory name_) external {
        list.push(Todo({name: name_, isCompleted: false}));
    }

    // 修改任务名称
    function modifyName1(uint256 _index, string memory _name) external {
        // 修改一个属性的时候比较省 gas
        list[_index].name = _name;
    }

    function modiName2(uint256 _index, string memory _name) external {
        // 方法二： 先存储存到 storage，再修改，在修改多个属性的时候比较节约gas
        Todo storage temp = list[_index];
        temp.name = _name;
    }

    // 修改完成状态
    function modiStatus1(uint256 _index, bool _status) external {
        list[_index].isCompleted = _status;
    }

    // 自动修改完成状态
    function modiStatus2(uint256 _index) external {
        list[_index].isCompleted = !list[_index].isCompleted;
    }

    // 获取任务
    function get1(uint256 index_) external view returns (string memory, bool) {
        Todo memory temp = list[index_];
        return (temp.name, temp.isCompleted);
    }

    // 获取任务方法二（gas更低）
    function get2(uint256 index_) external view returns (string memory, bool) {
      Todo storage temp = list[index_];
      return (temp.name, temp.isCompleted);
    }
}
