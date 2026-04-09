// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NPIIndex {

    address public owner;

    uint256 public gdp;        // current GDP per capita
    uint256 public baseGDP;    // GDP per capita (year 2000)
    uint256 public lastUpdate;

    uint256 constant MULTIPLIER = 1e18;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(uint256 _initialGDP, uint256 _baseGDP) {
        require(_baseGDP > 0, "Invalid base GDP");

        owner = msg.sender;
        gdp = _initialGDP;
        baseGDP = _baseGDP;
        lastUpdate = block.timestamp;
    }

    function updateGDP(uint256 _gdp) external onlyOwner {
        require(_gdp > 1000 && _gdp < 100000, "Invalid GDP");

        // optional: remove for testing
        // require(block.timestamp > lastUpdate + 365 days, "Too early");

        gdp = _gdp;
        lastUpdate = block.timestamp;
    }

    // 🔥 FINAL FORMULA
    // Price = 1.5 × (GDP / baseGDP)
    function getPrice() public view returns (uint256) {
        return (gdp * 15 * MULTIPLIER) / (10 * baseGDP);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }
}