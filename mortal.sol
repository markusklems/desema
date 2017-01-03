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

