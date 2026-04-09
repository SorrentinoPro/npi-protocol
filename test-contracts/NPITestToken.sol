// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NPITestToken {

    string public name = "NPI Test Token (BSC Testnet)";
    string public symbol = "NPIt";
    uint8 public decimals = 18;

    uint256 public totalSupply;

    address public owner;
    address public market;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(uint256 _supply) {
        owner = msg.sender;
        totalSupply = _supply;
        balanceOf[msg.sender] = _supply;
    }

    function setMarket(address _market) external onlyOwner {
        market = _market;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(balanceOf[from] >= amount, "Balance");
        require(allowance[from][msg.sender] >= amount, "Allowance");

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}