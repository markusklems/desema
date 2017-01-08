pragma solidity ^0.4.0;

contract ServiceRegistery {

    address contractOwner;
    uint public servicesCount = 0;

    mapping (bytes32 => address) public owners;
    mapping (uint => bytes32) public services;

    event NewService(
        bytes32 indexed _services
    );

    function ServiceRegistery() {
    }

    function register(bytes32 serviceHash) {
        if(owners[serviceHash] == address(0)){
            owners[serviceHash] = msg.sender;
            servicesCount++;
            services[servicesCount] = serviceHash;
            NewService(serviceHash);
        }
    }

    function changeOwnership(address add, bytes32 serviceHash) {
        if(owners[serviceHash] == msg.sender){
            owners[serviceHash] = add;
        }
    }

    function kill() { if (msg.sender == contractOwner) selfdestruct(contractOwner); }
}
