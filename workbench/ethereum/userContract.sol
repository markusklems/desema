pragma solidity ^0.4.2;

contract baseContract{

	address public owner;

	function baseContract(){
		owner = msg.sender;
	}

  	modifier onlyOwner{
  		if(msg.sender != owner){
    			throw;
  		}
  		else{
    			_;
  		}
	}

	function kill() onlyOwner{
  		suicide(owner);
	}
}

contract User {
    address public usrAdd;

    mapping(address => Service) public services;
    Service[] myConsumedservices;
    Service[] myProvidedservices;
    String public publicKey;

    struct Service{
        address serviceAddress;
        bytes32 serviceHash;
        uint lastUsage;
        uint256 numberUsage;
    }

    function User(String _publicKey){
        usrAdd = msg.sender;
        publicKey = _name;
    }

    function setServicePublicKey(String publicKey){
        //ToDo
    }

    function consumeService(address _serviceAddress, bytes32 _serviceHash) onlyOwner{
        // if service already not exist, just update usage information
        if(myConsumedservices[_serviceAddress] == 0){
            myConsumedservices[_serviceAddress] =({
                serviceAddress:_serviceAddress,
                serviceHash:_serviceHash,
                lastUsage:now,
                numberUsage:1
            });
        }
        else{
            myConsumedservices[_serviceAddress].lastUsage = now;
            myConsumedservices[_serviceAddress].numberUsage++;
        }

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
