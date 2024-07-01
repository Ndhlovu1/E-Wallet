pragma solidity 0.8.15;


contract ExampleMapping {

    mapping(uint => bool) public myMapping;

    function setValueToTrue(uint _index) public {

        myMapping[_index] = true;

    }

}

