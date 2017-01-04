

contract Service is mortal{

uint public servicePrice;

struct userInfo{

	address userAddress;
	String publicKey;
	uint lastUpdate;
	uint usage;


}



function Service(uint _price){
servicePrice = _price;

}


function setPrice(uint _price) onlyOwner{
	servicePrice = _price;

}

function consume(String publicKey){
	// exchange of public keys of the service to the user we need a function in user contract . 
	//payment 



User[publicKey] = userInfo({
   userAddress:msg.sender,
   publicKey:publicKey,
   lastUpdate:now,
   usage:0,
  });

  if(User[publikey].userAddress == msg.sender){
  User[publickey].usage += 1;
  }
  else{
  throw;
  }


  


}

//function setDebt(uint256 _debt, address _userAddress){


//User person = User(_userAddress);
//person.setDebt(_debt);
//}
//}