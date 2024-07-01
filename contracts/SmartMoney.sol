// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SmartMoney {

    //Variables
    uint public accountBalance;
    address payable public sendAccount;
    address payable public callingAccount;


    function deposit() public payable {
        if(msg.value > 10 wei){
            accountBalance = msg.value;
        }
    }

    function withdrawToAcc(address payable _sendAccount) public payable  {
        
        _sendAccount.transfer(accountBalance);
        sendAccount = _sendAccount;
        accountBalance = msg.value;

    }

      function withdrawAll() public  {
        
        address payable to = payable (msg.sender);
        to.transfer(accountBalance);

    }






}



