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
		String publicKey;
		uint lastUpdate;
		uint numberUsage;
	}

	function Service(uint _price){
		servicePrice = _price;
		}

	function setPrice(uint _price) onlyOwner{
		servicePrice = _price;
	}

	function consume(bytes32 publicKey){
		if(users[msg.sender].length == 0){
			users[msg.sender] = ({
	   			userAddress:msg.sender,
	   			publicKey:publicKey,
	   			lastUpdate:now,
	   			numberUsage:1,
	  		});
		}
		else{
			users[msg.sender].lastUpdate = now;
			users[msg.sender].numberUsage += 1
		}
  	}
}

//function setDebt(uint256 _debt, address _userAddress){


//User person = User(_userAddress);
//person.setDebt(_debt);
//}
//}
