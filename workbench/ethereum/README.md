# Ethereum Installation

- [For Mac](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac)  
- [For Windows](https://github.com/ethereum/go-ethereum/wiki/Installation-instructions-for-Windows)
- [For Ubuntu](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Ubuntu)

# Solidity Compiling
Since the native compilation of Solidity is tedious and prone to error, we could use the Browser-Based Compiler, which is a Browser-based IDE with integrated compiler and Solidity runtime environment without server-side components.
https://ethereum.github.io/browser-solidity

# Initialization


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
