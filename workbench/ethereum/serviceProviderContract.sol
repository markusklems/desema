

contract Service is mortal{
//string public providerName;
//string public description;
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

//providing the provider the prevelidge to access setDebt function.
//provider is setting up the debt of the specific user address

function setPrice(uint _price) onlyOwner{
	servicePrice = _price;

}

function consume(String publicKey){
	// exchange of public keys of the service to the user we need a function in user contract . 
	//payment 

}

function setDebt(uint256 _debt, address _userAddress){


User person = User(_userAddress);
person.setDebt(_debt);
}
}