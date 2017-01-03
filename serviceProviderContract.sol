//Service Provider Contract

contract Provider is mortal{
string public providerName;
string public description;

//constructor function 
function Provider(string _name,string _description){
providerName = _name;
description = _description;

}

//providing the provider the prevelidge to access setDebt function.
//provider is setting up the debt of the specific user address

function setDebt(uint256 _debt, address _userAddress){

__//creating the object of User contract__

User person = User(_userAddress);
person.setDebt(_debt);
}
}