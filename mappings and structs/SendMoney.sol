// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract SendMoney {

    string public myMessage = "Make a dent!";

    function updateMessage (string memory _message) public payable {
        if(msg.value == 1 ether){
            myMessage = _message;
        } else {
            //Send Back the money to the sender
            payable (msg.sender).transfer(msg.value);
        }

        //Send Money back to a payable address
    }



}
