// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SendMoneyFallback{

    uint public lastValueSent;
    string public lastFunctionCalled;

    uint public myFavouriteNumber;

    function setMyFavouriteNumber(uint _myFavNum) public {
         myFavouriteNumber = _myFavNum;
    }

    //Allow another contract to self destruct with another contract

    receive() external payable {
        //It only relies on 2000gas price and it is used to not do anything meaningfull
        lastValueSent = msg.value;
        lastFunctionCalled = "Received";
     }

     fallback() external payable {

        lastValueSent = msg.value;
        lastFunctionCalled = "Fallback";


      }

}