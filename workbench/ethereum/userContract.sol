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
	bytes32 public publicKey;

	mapping (address => user ) users;
	struct user{
		bytes32 publicKey;
		uint lastUpdate;
		uint countUsage;
	}

	function Service(){
		owner = msg.sender;
	}

	function setPrice(uint _price) onlyOwner{
		servicePrice = _price;
	}

	function consume(bytes32 _publicKey){
		if(users[msg.sender].publicKey == 0){
			users[msg.sender] = user({
	   			publicKey:_publicKey,
	   			lastUpdate:now,
	   			countUsage:1,
	  		});
			usersCount+=1;
		}
		else{
			users[msg.sender].lastUpdate = now;
			users[msg.sender].countUsage += 1;
		}
  	}
	
       // payable function:
        address public sendingAddress;
        uint public sendingMoney;
        function getMoney(address providerAddress) payable {
                sendingAddress = providerAddress;
                sendingMoney = msg.value;
        }
    
         function sendMoney() {
               if (!sendingAddress.send(sendingMoney)) throw;        
       }
	
}

contract User is baseContract {

	address public usrAdd;
	bytes32 public publicKey;

	mapping(address => ServiceInfo) public myConsumedServices;
	mapping(address => ServiceInfo) public myProvidedServices;


    struct ServiceInfo{
        address serviceAddress;
        bytes32 publicKey;
        uint lastUsage;
        uint256 countUsage;
    }

    function User(bytes32 _publicKey){
        usrAdd = msg.sender;
        publicKey = _publicKey;
    }

    function consumeService(address _serviceAddress) onlyOwner{
        // if service already not exist, just update usage information
        if(myConsumedServices[_serviceAddress].serviceAddress == 0){
            myConsumedServices[_serviceAddress] = ServiceInfo({
                serviceAddress:_serviceAddress,
                publicKey : 0,
                lastUsage:now,
                countUsage:1
            });
        }
        else{
            myConsumedServices[_serviceAddress].lastUsage = now;
            myConsumedServices[_serviceAddress].countUsage++;
        }
        Service service = Service(_serviceAddress);
//        _serviceAddress.send(service.servicePrice);
//        myConsumedServices[_serviceAddress].publicKey = service.publicKey;
    }
}
