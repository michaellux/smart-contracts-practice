// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays {
    address public owner;
    string[] public strings;

    event StringAdded(string newString);
    event StringDeleted(uint indexed index, string deletedString);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Добавление строки
    function addString(string memory newString) public onlyOwner {
        strings.push(newString);
        emit StringAdded(newString);
    }

    // Получение строки по индексу
    function getString(uint index) public view returns (string memory str) {
        require(index < strings.length, "Out of bounds");
        return strings[index];
    }

    // Удаление строки (с сохранением порядка)
    function deleteString(uint index) public onlyOwner {
        require(index < strings.length, "Out of bounds");
        string memory deleted = strings[index];
        for (uint i = index; i < strings.length - 1; i++) {
            strings[i] = strings[i + 1];
        }
        strings.pop();
        emit StringDeleted(index, deleted);
    }

    // Получение всех строк
    function getAllStrings() public view returns (string[] memory) {
        return strings;
    }
}
