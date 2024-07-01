// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleMapping2{

    //Track addresses to amount, People only have access to their own account
    mapping(address => uint) public balanceReceived;

    //Send Money to an address
    function sendMoney() payable public  {
        balanceReceived[msg.sender] += msg.value;
    }

    function getBalance() public view returns (uint) {

        return address(this).balance;
        

    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceReceived[msg.sender];      
        balanceReceived[msg.sender] = 0;//Re-Entrency Attacks
        _to.transfer(balanceToSendOut);
    }



}



