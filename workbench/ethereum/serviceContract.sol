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
