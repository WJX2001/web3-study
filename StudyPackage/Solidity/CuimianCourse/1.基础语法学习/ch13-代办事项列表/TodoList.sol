// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({text: _text, completed: false}));
    }

    function updateText(uint _index, string calldata _text) external {
        todos[_index].text = _text;

        // 第二种更新方法
        // Todo storage todo = todos[_index];
        // todo.text = _text;

        // 两种方法的gas不同
    }

    function get(uint _index) external view returns (string memory, bool) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }


    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }

}
