// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract BankMech {
    address public owner; 
    mapping (address => uint256) public balances;

    constructor(){
        //The owner should be who deploys the contract
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function deposit() public payable{
        //update owners balance with the new msg.value
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        //Ensure that the available balance is greater than amount to be withdrawn
        require(balances[msg.sender] >= amount, "Insufficient funds");
        //Subbtract amount from available balance
        balances[msg.sender] -= amount;
        //Make trf
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256){
        //Return current balance
        return balances[msg.sender];
    }

}