pragma solidity ^0.4.2;

contract mortal{

address public owner;


function mortal(){

owner = msg.sender;

}

  
  modifier onlyOwner{
  if(msg.sender != owner){
    throw;
  }
  else{
    _ ; __// this means that modifier will pass to function kill.__
  }
}


function kill() onlyOwner{

  suicide(owner);
}
}

