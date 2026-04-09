// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NPIIndex {

    uint256 public gdp;
    uint256 public npiIndex;
    uint256 public lastUpdate;

    address public owner;

    uint256 public constant MULTIPLIER = 1e18;
    uint256 public constant BASE = 10000;

    constructor(uint256 _initialGDP) {
        owner = msg.sender;
        gdp = _initialGDP;
        npiIndex = (_initialGDP * MULTIPLIER) / BASE;
        lastUpdate = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function updateGDP(uint256 _gdp) external onlyOwner {

        require(_gdp > 1000 && _gdp < 100000, "Invalid GDP");

        require(
            _gdp >= gdp - 1000 && _gdp <= gdp + 1000,
            "GDP jump too large"
        );

        require(
            block.timestamp > lastUpdate + 365 days,
            "Too early"
        );

        gdp = _gdp;
        npiIndex = (_gdp * MULTIPLIER) / BASE;
        lastUpdate = block.timestamp;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Zero address");
        owner = newOwner;
    }
}