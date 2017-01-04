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

