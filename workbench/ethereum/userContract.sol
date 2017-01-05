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

contract Service is baseContract{

	uint public servicePrice;
	user[] users;

	struct user{
		address userAddress;
		bytes32 userPubKey;
		uint lastUpdate;
		uint numberUsage;
	}

	function Service(){
		}

	function setPrice(uint _price) onlyOwner{
		servicePrice = _price;
	}

	function consume(bytes32 publicKey){
		if(users[msg.sender].length == 0){
			users[msg.sender]= User({
	   			userAddress:msg.sender,
	   			publicKey:publicKey,
	   			lastUpdate:now,
	   			numberUsage:1
	  		});
		}
		else{
			users[msg.sender].lastUpdate = now;
			users[msg.sender].numberUsage += 1;
		}
  	}
}

contract User is baseContract {
    address public usrAdd;

    //mapping(address => Service) public services;

    Service[] myConsumedservices;
    Service[] myProvidedservices;
    bytes32 public publicKey;

    struct ServiceInfo{
        address serviceAddress;
        bytes32 publicKey;
        bytes32 serviceHash;
        uint lastUsage;
        uint256 numberUsage;
    }

    function User(bytes32 _publicKey){
        usrAdd = msg.sender;
        publicKey = _publicKey;
    }

    function setServicePublicKey(String publicKey){
        //ToDo
    }

    function consumeService(address _serviceAddress, bytes32 _serviceHash) onlyOwner{
        // if service already not exist, just update usage information
        if(myConsumedservices[_serviceAddress] == 0){
            myConsumedservices[_serviceAddress] = ServiceInfo({
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
        Service service = Service();
        _serviceAddress.send(service.Price);
        myConsumedservices[_serviceAddress].publicKey = service.publicKey;
    }
}
