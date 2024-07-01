// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

//Assert has no message, simply an errorCode  
//Custom E  rrorsare caught with some law level data

/*
    Require can be caught with the : "Error" keyword

    Assert can be caught with : "Panic" keyword

    Custom errors : Can be created from scratch



*/

contract WillThrow {

    //Define your own errors
    error NotAllowedError(string);

    function aFunction() public pure{
        //require(false, "ErorMessage");
        //assert(false);
        revert NotAllowedError("You are not allowed!");
    }
}

contract ErrorHandling {

    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowlevelData);

    function catchTheError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {

        }
        catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
        catch Panic(uint errorCode){
            emit ErrorLogCode(errorCode);
        }
        catch (bytes memory lowlevelData){
            emit ErrorLogBytes(lowlevelData);
        }
        
    }



}


