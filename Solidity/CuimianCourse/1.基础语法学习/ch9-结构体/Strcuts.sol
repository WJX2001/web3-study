// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        Car memory toyota = Car("Toyota", 1990, msg.sender);

        // 这种写法不需要按结构体顺序进行赋值
        Car memory lambo = Car({
            model: "Lamborghini",
            year: 1990,
            owner: msg.sender
        });

        // 一开始不进行赋值
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;
        
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        // 推入的时候 直接初始化 在内存中，推入后存入状态变量
        cars.push(Car("Ferrari", 2020, msg.sender));

        // 内存中是不能够修改和删除的
        Car memory _car = cars[0];
        _car.model;
        _car.year;
        _car.owner;

        // 使用存储的方式 可以修改 也就是使storage
        Car storage _car2 = cars[0];
        _car2.year = 1999;
        delete _car2.owner;
        delete cars[1];
    }
}
