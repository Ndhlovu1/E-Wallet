// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MappingStructExample {

    /*      REQUIREMENT FUNCTIONS

        Deposit, WIthdraw and Get User Balance

            IN ORDER TO TRACK DEPOSITS OUTSIDE OF THE BLOCK EXPLORER

        Structs are useful for recording transactions, Mappings dont have a length
        
    */

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Transaction) deposits;
        uint numWithdrawals;
        mapping(uint => Transaction) withdrawals;
    }

    mapping (address => Balance) public balances;

    function depositMoney() public payable {
        balances[msg.sender].totalBalance += msg.value;

        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;
        balances[msg.sender].numDeposits++;

       }

    function withdrawMoney(address payable _to, uint _amount) public {
        balances[msg.sender].totalBalance -= _amount;

        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawals[balances[msg.sender].numWithdrawals] = withdrawal;
        balances[msg.sender].numWithdrawals++;

        _to.transfer(_amount);
    }

    //Getter Functions for deposits
    function getDeposit (uint _numDeposits, address _from) public view returns (Transaction memory){
        return balances[_from].deposits[_numDeposits];
    }


}



