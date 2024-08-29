// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract AccessControl {
    event GrantRole(bytes32 role, address indexed account);
    event RevokeRole(bytes32 role, address indexed account);
    // role => account => bool
    // 由角色 -> 到账户 -> 再到布尔值的一个映射

    mapping(bytes32 => mapping(address => bool)) public roles;

    // 定义角色名称
    // 私有变量消耗的gas值要比公有变量的少
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    // 函数修改器
    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    // 构造函数 用于解决 一开始谁都没有管理员权限的问题
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    // 升级函数 给账户赋予权限
    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }
    // 外部可用
    function grantRole(
        bytes32 _role,
        address _account
    ) external onlyRole(ADMIN) {
        _grantRole(_role, _account);
    }

    // 撤销权限
    function revokeRole(
        bytes32 _role,
        address _account
    ) external onlyRole(ADMIN) {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }
}
