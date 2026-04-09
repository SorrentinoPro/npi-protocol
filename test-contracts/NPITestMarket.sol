// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INPIIndex {
    function getPrice() external view returns (uint256);
}

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract NPIMarket {

    IERC20 public token;
    INPIIndex public index;

    constructor(address _token, address _index) {
        token = IERC20(_token);
        index = INPIIndex(_index);
    }

    // BUY TOKEN WITH BNB
    function buy() external payable {
        require(msg.value > 0, "No BNB sent");

        uint256 price = index.getPrice();

        // tokens = BNB / price
        uint256 tokens = (msg.value * 1e18) / price;

        require(token.balanceOf(address(this)) >= tokens, "No liquidity");

        token.transfer(msg.sender, tokens);
    }

    // SELL TOKEN FOR BNB
    function sell(uint256 amount) external {
        require(amount > 0, "Invalid amount");

        uint256 price = index.getPrice();

        // BNB = tokens * price
        uint256 bnbAmount = (amount * price) / 1e18;

        require(address(this).balance >= bnbAmount, "No BNB");

        token.transferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(bnbAmount);
    }
}