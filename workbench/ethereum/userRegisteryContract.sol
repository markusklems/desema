pragma solidity ^0.4.2;

contract UserRegistery{
    mapping (address => address) private userContracts;
    functin UserRegistery(){

    }

    function getUserContractAddress() returns(address) {
        if(userContracts[msg.sender] != address(0)){
            return userContracts[msg.sender];
        }
    }

    function setUserContractAddress(address userContractAdd) {
        if(userContracts[msg.sender] == address(0)){
            userContracts[msg.sender] = userContractAdd;
        }
    }

}
