solidity ^0.4.0;

contract User {
    address public usrAdd;
    string public userName;

    mapping(address => Service) public services;
    Service[] myservices;

    struct Service{
        address serviceAdd;
        bytes32 serviceHash;
        uint lastUsage;
        uint256 totalPaied;
    }

    function User(string _name){
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

    function setDebt(uint256 _debt){
        if(services[msg.sender].active){
            services[msg.sender].lastUpdate = now;
            services[msg.sender].debt = _debt;
        }
        else{
            throw;
        }
    }

    function payToProvider(address _providerAddress){
        _providerAddress.send(services[_providerAddress].debt);
    }

    function unsubscribe(address _providerAddress){
        if(services[_providerAddress].debt == 0]){
            services[_providerAddress].active = false;
        }
        else{
            throw;
        }
    }
}

