pragma solidity ^0.4.0;

contract Provider {
    address public providerAdd;

    mapping(address => Service) public services;
    Service[] myservices;

    struct Service{
        address serviceAdd;
        bytes32 serviceHash;
        uint nbCurrentUsers;
        uint256 totalUsage;
    }

    function Provider(string _name){
        usrAdd = msg.sender;
        userName = _name;
    }

    modifier onlyOwner{
        if(msg.sender != usrAdd){
            throw;
        }
        else{
            _ ;
        }
    }
    
    function setServicePublicKey(String publicKey){
        
    }

    function registerToService(address serviceAddress) onlyOwner{
        // if service already not exist, just update usage information
        services[providerAddress] = Service({
            active:true,
            lastUpdate:now,
            debt:0
        });
        
        //else put a new service struct
        
        // call service.consume
    }
}
