// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Consumer {

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function deposit() public payable {}


}

contract EWallet {

    address payable public walletOwner;
    address payable nextOwner;
    mapping (address => uint) public allowance;
    mapping (address => bool) isAllowedToSend;
    mapping (address => bool) public guardians;
    mapping (address => mapping(address => bool)) nexOwnerGuardianVotedBool;
    uint guardianResetCount;
    uint public constant confirmationFromGuardiansForReset = 3;

    constructor(){
        walletOwner = payable(msg.sender);
    }

    receive() external payable { }

    //Create several guardians of the wallet in the event it gets lost
    function setGuardian(address _guardian, bool _isGuardian) public {
         require(msg.sender == walletOwner, "You are not the owner");
         guardians[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "Only guardians allowed.");
        require(nexOwnerGuardianVotedBool[_newOwner][msg.sender] == false, "You already voted");
        if(_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardianResetCount = 0;
        }

        guardianResetCount++;

        if(guardianResetCount >= confirmationFromGuardiansForReset){
            walletOwner = nextOwner;
            nextOwner = payable (address(0));
        }

    }

    //Create an allowance amount needed
    function setAllowance(address _for, uint _amount) public {

        require(msg.sender == walletOwner, "Not the owner!");
        allowance[_for] = _amount;

        if(_amount > 0){
            isAllowedToSend[_for] = true;
        }
        else{
            isAllowedToSend[_for] = false;
        }


    }

    function transferFunds(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory) {
        require(msg.sender == walletOwner, "You aint the owner");

        if(msg.sender != walletOwner){
            require(isAllowedToSend[msg.sender], "Insufficient Permissions!");
            require(allowance[msg.sender] >= _amount, "Not allowed to send too much money");

            allowance[msg.sender] -= _amount;
        }     
        
        (bool success, bytes memory returnData) = _to.call{ value: _amount }(_payload);

        require(success, "Call was not successful");
        return returnData;

    }





}