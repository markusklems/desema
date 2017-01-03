
contract User is mortal {
string public userName;


mapping(address => Service) public services;

struct Service{
bool active; __// whether subscribed a service or not__
uint lastUpdate; __// when did the user last time interacted with the service.__
uint256 debt; __// ether transfer__
}

function User(string _name){
userName = _name;
}


//function making user to register with the provider who is providing the service

function registerToProvider(address _providerAddress) onlyOwner{

services[_providerAddress] = Service({
   active:true,
   lastUpdate:now,
   debt:0
  });
}



//setting up the cost of services

  function setDebt(uint256 _debt){

if(services[msg.sender].active){
  services[msg.sender].lastUpdate = now;
  services[msg.sender].debt       = _debt;



}
else{
  throw;
}
}

//paying the fee

function payToProvider(address _providerAddress){
_providerAddress.send(services[_providerAddress].debt);

}

//unsubscribing from the service

function unsubscribe(address _providerAddress){
if(services[_providerAddress.debt == 0]){
  services[_providerAddress].active = false;
}
else{
  throw;
}
}
}


