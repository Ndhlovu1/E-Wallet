// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExampleExceptionRequire{

    //Input Validation, for gas optimization use uint8
    mapping (address => uint8) public balanceReceived;

    function receiveMoney() public payable {

        //Assert is used for testing 
        assert(msg.value == uint8(msg.value));

        balanceReceived[msg.sender] += uint8(msg.value);
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
        //Require is for validation
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
        balanceReceived[msg.sender] -= _amount;

        _to.transfer(_amount);

    }



}


