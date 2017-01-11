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

	function setPublicKey(bytes32 _publicKey) onlyOwner{
		publicKey = _publicKey;
	}

	function consume(bytes32 _publicKey, address userAddress) payable costs(servicePrice){
		if(users[userAddress].publicKey == 0){
			users[userAddress] = user({
	   			publicKey:_publicKey,
	   			lastUpdate:now,
	   			countUsage:1,
	  		});
			usersCount+=1;
		}
		else{
			users[userAddress].lastUpdate = now;
			users[userAddress].countUsage += 1;
		}

// 		The payment from the user address to the service contract
//		the value is in Wei, we need to send ether
//		getMoney(userAddress,{gas:500000,value:11111111})
  	}

    // payable function:
    address public sendingAddress;
    uint public sendingMoney
    function getMoney(address providerAddress) payable {
        sendingAddress = providerAddress;
        sendingMoney = msg.value;
    }

    function sendMoney() {
    	if (!sendingAddress.send(sendingMoney)) throw;
    }

	function withdraw()onlyOwner {
		//TODO
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
	//this function should be payable
    function consumeService(address _serviceAddress) onlyOwner payable{
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
		service.consume.value(service.servicePrice)(publicKey,owner); //not always working
        myConsumedServices[_serviceAddress].publicKey = service.publicKey;
    }
}
