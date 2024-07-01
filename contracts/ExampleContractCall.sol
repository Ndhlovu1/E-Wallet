// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ContractOne{

    mapping (address => uint) public addressBalances;
    //Holding the ether per given contract address
    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }

    receive() external payable {
        deposit();
     }

}

contract ContractTwo{

    receive() external payable { }

    function depositOnContractOne(address _contractOne) public {
        //Use the first 8 characters that define what type of function is going to be called
        bytes memory payload = abi.encodeWithSignature("deposit()");
        (bool success,) = _contractOne.call{value : 10, gas: 100000}(payload); //Use the native sending of funds to our contract
        require(success);
    }


}

