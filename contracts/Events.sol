// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Events {
    address public owner;

    uint public stateVariable;

    mapping(address => uint) public balances;

    event ChangeVariable(uint indexed variable);
    event Deposit(address indexed sender, uint indexed value, uint totalBalance);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Изменение переменной (только для владельца)
    function changeVariable(uint variable) public onlyOwner {
        stateVariable = variable;
        emit ChangeVariable(stateVariable);
    }

    // Депозит ETH
    function deposit() public payable {
        require(msg.value > 0, "ETH must > 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value, balances[msg.sender]);
    }

    // Получение баланса пользователя
    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }
}
