pragma solidity ^0.4.0;
contract registerHash {
  uint addressCounter;
  mapping (uint => address) addressList;
	mapping (address => uint) hashCounterForAddress;
	mapping (address => mapping (uint => string)) hashList;

	function getAddressCount() returns (uint count) {
	    return addressCounter;
	}

  function getAddressAtIndex(uint index) returns (address returnAddress) {
      return addressList[index];
  }

  function getHashCountOfAddress(address sellerAddress) returns (uint count) {
      return hashCounterForAddress[sellerAddress];
  }

  function getHashAtIndexForAddress(uint index, address sellerAddress) returns (string hash) {
      return hashList[sellerAddress][index];
  }

  function saveNewHash(string hashString) {
      //check address first
      address sellerAddress = msg.sender;
      bool addressExist = false;
      for (uint i=1; i<= addressCounter; i++) {
          if (addressList[i] == sellerAddress) {
              addressExist = true;
              break;
          }
      }
      if (addressExist) {
          //Not new address
          uint hashCounter = hashCounterForAddress[sellerAddress];
          hashCounter += 1;
          hashCounterForAddress[sellerAddress] = hashCounter;
          hashList[sellerAddress][hashCounter] = hashString;
      } else {
          //Add new address
          addressCounter += 1;
          addressList[addressCounter] = sellerAddress;
          //New hash counter
          hashCounterForAddress[sellerAddress] = 1;
          //Save new hash string
          hashList[sellerAddress][1] = hashString;
      }
    }
	//TODO: check duplicate hash:
	//Soft error, same address upload same hash.
	//Hard error, different address upload same hash. (private)

  //TODO: further features:
  //Remove service hash.
  //Update service hash to new service hash.
}
