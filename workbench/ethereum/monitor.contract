pragma solidity ^0.4.0;

contract monitorContract {
    
    struct monitorInfo {
        address buyerAddress;  // could change this into other address
        bytes32 serviceUrl;
    }
    
    uint public monitorInfoCount;
    
    mapping(uint => monitorInfo) public monitorResults;
    
    event newMonitorRecord(address buyerAddress, bytes32 url);
    
    function monitor (address buyerAddress, bytes32 url) returns (uint monitorIndex) {
        monitorInfoCount += 1;
        monitorResults[monitorInfoCount].buyerAddress = buyerAddress;
        monitorResults[monitorInfoCount].serviceUrl = url;
        newMonitorRecord(buyerAddress, url);
        return monitorInfoCount;
    }
}
