// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {
    address public owner;
    uint public lastCallTime;

    event TimeCallUpdated(uint timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function updateCallTime() public onlyOwner {
        lastCallTime = block.timestamp;
        emit TimeCallUpdated(block.timestamp);
    }
}