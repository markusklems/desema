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
}
