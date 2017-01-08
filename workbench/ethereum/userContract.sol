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
	uint public usersCount;

	mapping (address => user ) users;
	struct user{
		String publicKey;
		uint lastUpdate;
		uint countUsage;
	}

	function Service(){
		owner = msg.sender;
	}

	function setPrice(uint _price) onlyOwner{
		servicePrice = _price;
	}

	function consume(bytes32 publicKey){
		if(users[msg.sender].length == 0){
			users[msg.sender] = ({
	   			publicKey:publicKey,
	   			lastUpdate:now,
	   			countUsage:1,
	  		});
			usersCount+=1;
		}
		else{
			users[msg.sender].lastUpdate = now;
			users[msg.sender].countUsage += 1
		}
  	}
}

contract User is baseContract {

	address public usrAdd;
	bytes32 public publicKey;

	mapping(address => Service) public myConsumedServices;
	mapping(address => Service) public myProvidedServices;


    struct ServiceInfo{
        address serviceAddress;
        bytes32 publicKey;
        bytes32 serviceHash;
        uint lastUsage;
        uint256 countUsage;
    }

    function User(bytes32 _publicKey){
        usrAdd = msg.sender;
        publicKey = _publicKey;
    }

    function consumeService(address _serviceAddress) onlyOwner{
        // if service already not exist, just update usage information
        if(myConsumedservices[_serviceAddress] == 0){
            myConsumedservices[_serviceAddress] = ServiceInfo({
                serviceAddress:_serviceAddress,
                lastUsage:now,
                countUsage:1
            });
        }
        else{
            myConsumedservices[_serviceAddress].lastUsage = now;
            myConsumedservices[_serviceAddress].countUsage++;
        }
        Service service = Service();
        _serviceAddress.send(service.Price);
        myConsumedservices[_serviceAddress].publicKey = service.publicKey;
    }
}
