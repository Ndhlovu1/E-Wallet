// SPDX-License-Identifier: MIT
pragma solidity ^0.5.13;


contract FundTransfers{

    //uint public balanceSent;
    //uint public balanceReceived;
    address public senderAccount;
    address owner;
    //To pause the transaction
    bool public paused;

    constructor() public  {
        owner = msg.sender;
    }

    //A function to receive funds from an account to the contract
    function receiveMoney() public payable {
       // balanceSent = msg.value / 10 ** 18;
       // balanceReceived += msg.value / 10**18;
        senderAccount = msg.sender;
    }

    //Get Balance of the smart contract
    function getContractBalance() public view returns (uint){
        return address(this).balance / 10**18;       
    }

    //Withdraw the money
    function withdrawMoneyToIndividual() public {

        //Using the require statement will allow automatically measuring the quality being offered
        require(msg.sender == owner, "Permission Denied");
        require(paused == false, "Contract is paused!");
        address payable to = msg.sender;
        to.transfer(this.getContractBalance());
    } 

    function sendEther(address payable _to, uint _amount) public {
        _amount = _amount * 10**18;
        _to.transfer(_amount);       

    }

    function setPausedStatus(bool _paused) public {
        require(msg.sender == owner, "Permission Denied");
        paused = _paused;
    }

    function destroySmartContract(address payable _retainFunds) public {
        require(msg.sender == owner, "Permission Denied");
        selfdestruct(_retainFunds);
    }












}



