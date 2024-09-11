// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-test-helpers/blob/master/contracts/Ownable.sol";

contract SharedWallet is Ownable{

    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    event withdrawMoney(address indexed _byWhom, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount );


    mapping (address => uint) public accountDetails;
    mapping (address => uint) public allowance;
    uint amount;

    //Fallback function
    function () external payable {
        emit MoneyReceived(msg.sender, msg.value/10 **18); 
    }

    modifier allowedOwner(uint _amount) {
        require(isOwner() || allowance[msg.sender] > _amount, "Permission Denied");
        _;
    }
    
    modifier aboveZero() {
        require(amount >= 0 );
        _;
    }

    function addAllowance(address payable _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance (address _who, uint _amount) internal {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }




    //Withdraw Money
    function withdraw(address payable _to, uint _amount) public allowedOwner(_amount) {
        require(_amount <= address(this).balance, "Insufficient Funds");

        if(!isOwner()){
            reduceAllowance(msg.sender, _amount);
        }

        emit withdrawMoney(_to, _amount);
        _to.transfer(_amount);

    }

    function renounceOwnership() public {
        revert("Can't renounce Ownership!");
    }



}



