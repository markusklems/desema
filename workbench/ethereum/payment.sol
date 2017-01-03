pragma solidity ^0.4.2;

contract mortal{
// address is a pre defined variable in solidity
address public owner;

//constructor without any arguments
function mortal(){

__//msg is predefined object in solidity__
__//compiler takes address of the sender of contract__
__//and place it in the owner.__
owner = msg.sender;

}

__//modifier will put restrictions__
__//only owner can access the kill function__
__//not the contracts that are inheriting this contract.__
  
  modifier onlyOwner{
  if(msg.sender != owner){
    throw;
  }
  else{
    _ ; __// this means that modifier will pass to function kill.__
  }
}

__//cant delete something which is in the blockchain__
__//but can surely stop it and this is done by kill().__
__//onlyOwner modifier is used which makes the function kill__
__//executed by only the owner.__

function kill() onlyOwner{

  __//it is a predefined function .__
  __//will return the leftover ether to the owner.__

  suicide(owner);
}
}










//USER CONTRACT 



// User Contract
//this exhibits inheritence
//contract User now has all the functionlity of mortal

contract User is mortal {
string public userName;



//mapping services corresponds to address of the provider 
//it maps the address of the provider providing the specified service
//this info will be stored in the array service
mapping(address => Service) public services;



//user need to be associated with different services
//service can be anything offered
//struct needs to create different objects stands for service 
struct Service{
bool active; __// whether subscribed a service or not__
uint lastUpdate; __// when did the user last time interacted with the service.__
uint256 debt; __// ether transfer__
}


//CONSTRUCTOR FUNCTION first this function is completed then only the USER CONTRACT will be executed.
function User(string _name){
userName = _name;
}


//function making user to register with the provider who is providing the service
//only the user contract owner will be able to register with the service provider.
function registerToProvider(address _providerAddress) onlyOwner{

__//array of services for that provider address and the things that it should exhibit.__
services[_providerAddress] = Service({
   active:true,
   lastUpdate:now,
   debt:0
  });
}



//setting up the cost of services

  function setDebt(uint256 _debt){

__//it will find the address of the service provider and will check whether__
__//the service is active or not.__
__//msg.sender is the address of the provider__
__//user cannot use this function__
// msg.sender will be th address of the provider contract 

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