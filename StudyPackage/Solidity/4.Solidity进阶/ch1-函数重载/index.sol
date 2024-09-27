// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FunctionOverloading {
    function saySomething() public pure returns (string memory) {
        return ("Nothing");
    }

    function saySomething(
        string memory something
    ) public pure returns (string memory) {
        return (something);
    }

    
}
