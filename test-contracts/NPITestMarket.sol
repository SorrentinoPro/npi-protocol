// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

interface INPIIndex {
    function npiIndex() external view returns (uint256);
}

contract NPITestMarket {

    IERC20 public token;
    INPIIndex public index;

    address public owner;

    constructor(address _token, address _index) {
        token = IERC20(_token);
        index = INPIIndex(_index);
        owner = msg.sender;
    }

    function getPrice() public view returns (uint256) {
        return index.npiIndex();
    }

    function buy() external payable {
        uint256 price = getPrice();
        require(price > 0, "Invalid price");

        uint256 amount = (msg.value * 1e18) / price;

        require(token.balanceOf(address(this)) >= amount, "No liquidity");

        token.transfer(msg.sender, amount);
    }

    function sell(uint256 amount) external {
        uint256 price = getPrice();

        uint256 bnbAmount = (amount * price) / 1e18;

        require(address(this).balance >= bnbAmount, "No BNB");

        token.transferFrom(msg.sender, address(this), amount);

        payable(msg.sender).transfer(bnbAmount);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }
}