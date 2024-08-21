// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract ArrayExample {
    uint[][] public storageArr;
    function initArray() public {
        uint n = 2;
        uint m = 3;
        for (uint i = 0; i < n; i++) {
            storageArr.push(new uint[](m));
        }
        
    }
    
}
