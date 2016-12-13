# Ethereum Installation

- [For Mac](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac)  
- [For Windows](https://github.com/ethereum/go-ethereum/wiki/Installation-instructions-for-Windows)
- [For Ubuntu](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Ubuntu)


# Initialization

### Launch geth:
Run this command when first time to setup the ethereum.

    > geth --identity "MyNodeName" --rpc --rpcport "8080" --rpccorsdomain "*" --datadir "C:\chains\TestChain1" --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --networkid 1999 init /path/to/CustomGenesis.json

### initialize the genesis block:
You have to run this initial command everytime when you start ethereum.

    > geth --identity "MyNodeName" --rpc --rpcport "8080" --rpccorsdomain "*" --datadir "C:\chains\TestChain1" --port "30303" --nodiscover --rpcapi "db,eth,net,web3" --networkid 1999 console



# Account 

**WARNING:** Remember your password.  
It is NOT possible to access your account without a password and there is no forgot my password option here. Do not forget it.

### Creating a new account
    > personal.newAccount("password")
  
### Listing your current accounts
    > eth.accounts

### Checking account balances
    > web3.fromWei(eth.getBalance(eth.coinbase), "ether")

### Unlock account
    > personal.unlockAccount(address, "password")

[Find more about Managing accounts](https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts)
   
# Mining
In order to earn ether you must have your etherbase (or coinbase) address set. This etherbase defaults to your primary account.

### Set etherbase
    > geth --etherbase '0xa4d8e9cae4d04b093aac82e6cd355b6b963fb7ff' --mine 2>> geth.log

### Reset etherbase
    > miner.setEtherbase(eth.accounts[2])
    
### Mining process
`miner.start` takes an optional parameter for the number of miner threads.  
First time when running the mining command, it will need more time to generate.

    > miner.start(8)
    > true
    > miner.stop()
    > true    
  
# Transactions
    > eth.sendTransaction({from: '0x036a03fc47084741f83938296a1c8ef67f6e34fa', to: '0xa8ade7feab1ece71446bed25fa0cf6745c19c3d5', value: web3.toWei(1, "ether")})
    
NOTICE: If you just give numbers to `value`, such as `value: 100`, please notice that the unit of value number is really small: 1 ether = 1000000000000000000 = 1e18
 
# Contracts

### Solidity Compiling
Since the native compilation of Solidity is tedious and prone to error, we could use the Browser-Based Compiler, which is a Browser-based IDE with integrated compiler and Solidity runtime environment without server-side components.
https://ethereum.github.io/browser-solidity

After you finish compiling, you will have three things:
**Bytecode, Interface, Web3 deploy**

### Deploy and call
    > txhash = eth.sendTransaction({from:"account1", gas:999999999999, gasPrice:1, data:"bytecode"})  
    > contractaddress = eth.getTransactionReceipt(txhash)
    
Check if the deployment is successful or not, this command will return the contract bytecode.
     
     > eth.getCode(contractaddress)

Use the interface from the compile result of solidity to setup abi:

    > abi = interface 
    
Declare the name of this contract class:

    > className = eth.contract(abi)
    
Declare the name of contract instance:

    > instanceName = className.at("contractaddress")
    
Call this contract, functionName is the function name inside the function

    > instanceName.functionName.call(parameter)
