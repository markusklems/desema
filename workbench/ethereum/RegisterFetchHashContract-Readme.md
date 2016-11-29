## Introduction 

This contract has two general functions:

- Register service hash and owners addresses  
This contract can save multiple addresses (multiple owners), and each address can have multiple service hashes.     
**Function**: saveNewHash(string hashString)  
**Note**: this function have to be called by sendTransaction() 

- List all registered service hash and owners addresses  
Because of the limitation of solidity language, there is no easy way to return any kind of data collections. For this reason, this contract provide 4 different methods as API. Client can create logic to get the whole list via API methods.   
With the first two functions below, client can create an easy *for* loop to fetch the list of service owner. with the other two function below, client can create an easy for loop to fetch the hash list of one owner.   
**Function**: getAddressCount() - return the total count of service owners.   
**function**: getAddressAtIndex(uint index) - return the own address by index.  
**function**: etHashCountOfAddress(address sellerAddress) - return the total count of services this owner registered.  
**function**: getHashAtIndexForAddress(uint index, address sellerAddress) - return the service hash of this owner base on index. 

Combine with owner list and each owners hash list, we have the whole service list. 

## Install and test

**Test environment**:   
This contract has only tested on ethereum testnet via geth client. To set up ethereum testnet, please check this tutorial:  
http://www.ethdocs.org/en/latest/network/test-networks.html#setting-up-a-local-private-testnet  
For test purpose please create at least 2 accounts and both should have enough ethers inside (For test mining, 1 min can get more than 800 ethers).

**Compile**:  
Geth can directly compile the code after installing solidity compiler. Although, a more easier way is this online compile tool:   
https://ethereum.github.io/browser-solidity/#version=soljson-v0.4.6
  

**Deploy**:
> use eth.sendTransaction({from:, gas:, gasPrice:, data:}) to deploy contract  

Note as there is data storage for this contract, we need really high gas for deploy. 

## Terms Definition
owner - service owner (or service seller). Each owner can have multiple services.  
service hash - IPFS hash. Service metadata can be fetched via this hash from IPFS.  
owner address - owner's node address in ethereum network. This is the identifier of the owner.  
