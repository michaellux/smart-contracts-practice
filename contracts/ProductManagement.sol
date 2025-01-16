// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductManagement {
    address public owner;

    struct Product {
        string name;
        uint price;
        address owner;
    }

    Product[] public products;

    event ProductAdded(string name, uint price, address indexed owner);
    event ProductUpdated(uint indexed index, string name, uint price);
    event ProductRemoved(uint indexed index, string name);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }

    modifier onlyProductOwner(uint index) {
        require(index < products.length, "Product index out of bounds");
        require(msg.sender == products[index].owner, "Only product owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addProduct(string memory _name, uint _price) public onlyOwner {
        require(bytes(_name).length > 0, "Product name cannot be empty");
        require(_price > 0, "Price must be greater than zero");
        products.push(Product(_name, _price, msg.sender));
        emit ProductAdded(_name, _price, msg.sender);
    }

    function updateProduct(uint index, string memory _name, uint _price) public onlyProductOwner(index) {
        require(bytes(_name).length > 0, "Product name cannot be empty");
        require(_price > 0, "Price must be greater than zero");

        Product storage product = products[index];
        product.name = _name;
        product.price = _price;

        emit ProductUpdated(index, _name, _price);
    }

    function removeProduct(uint index) public onlyProductOwner(index) {
        require(index < products.length, "Product index out of bounds");

        string memory name = products[index].name;
        products[index] = products[products.length - 1];
        products.pop();

        emit ProductRemoved(index, name);
    }

    function getProduct(uint index) public view returns (string memory, uint, address) {
        require(index < products.length, "Product index out of bounds");
        Product memory product = products[index];
        return (product.name, product.price, product.owner);
    }

    function getAllProducts() public view returns (Product[] memory) {
        return products;
    }
}
