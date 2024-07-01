// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract ExampleSendTransfer{

    //When to use send & transfer

    /*

        Transfer : Throws an error when a transfer fails

        Send : Will return a boolean of the response, hence use the require to verify the boolean


    */

    receive() external payable {

     }

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);

    }

    function withdrawSend(address payable _to) public {
        bool isSent = _to.send(10); //Send From a smart contranct

        require(isSent,"Failure sending transactions!");

    }
}

contract ReceiveNoAction {

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable { }

}

contract ReceiverAction {
    uint public balanceRecieved;

    receive() external payable {
        balanceRecieved += msg.value;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }



}

