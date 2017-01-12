pragma solidity ^0.4.0;
contract marketPlacePayment {
    
    struct serviceOrder {
        uint serviceID; //hash, string or uint. Depends on register hash service
        address buyerAddress;
        string buyerPublicKey;
        uint payment;
        bool available;
    }
    
    struct service {
        address sellerAddress;
        uint servicePrice;
    }
    
    struct buyerOrder {
        address sellerAddress;
        uint serviceOrderIndex;
    }
    address contractOwner;
    
//Init&kill 
    function marketPlacePayment() { contractOwner = msg.sender; }
    function Kill() { if (msg.sender == contractOwner) selfdestruct(contractOwner); }
    
//Business logic

//Option 1: use event to log the new order & confirm order
    event newOrder (uint indexed _orderIndex, address indexed _sellerAddress, string _buyerPublicKey);
    event confirmOrder (uint indexed _orderIndex, address indexed _sellerAddress);
    
//Option 2: call public getter to list new orders with for loop    
    mapping(address => mapping(uint => serviceOrder)) public orders;
    mapping(address => uint) public orderIndex;
    mapping(uint => service) public services;
    
//Buyers order list
    mapping(address => mapping(uint => buyerOrder)) public buyerOrderList;
    mapping(address => uint) public buyerOrderIndex;
    
    function registerNewService(uint serviceID, uint price) {
        service thisService = services[serviceID];
        thisService.sellerAddress = msg.sender;
        thisService.servicePrice = price;
    }   
    
    function orderService(uint serviceID, address sellerAddress, string publicKey) payable returns (uint serviceIndex) {
        service orderedService = services[serviceID];
        uint servicePrice = orderedService.servicePrice;
        if (msg.value >= servicePrice) {
            orderIndex[sellerAddress] += 1;
            uint newOrderIndex = orderIndex[sellerAddress];
            orders[sellerAddress][newOrderIndex].serviceID = serviceID;
            orders[sellerAddress][newOrderIndex].buyerAddress = msg.sender;
            orders[sellerAddress][newOrderIndex].payment = msg.value;
            orders[sellerAddress][newOrderIndex].available = false;
            orders[sellerAddress][newOrderIndex].buyerPublicKey = publicKey;
        
            newOrder (newOrderIndex, sellerAddress, publicKey);
            
            uint rest = msg.value - servicePrice;
            if (rest > 0) {
//               if (!msg.sender.send(rest)) throw;
            }
            
            buyerOrderIndex[msg.sender] += 1;
            uint newBuyerOrderIndex = buyerOrderIndex[msg.sender];
            buyerOrderList[msg.sender][newBuyerOrderIndex].sellerAddress = sellerAddress;
            buyerOrderList[msg.sender][newBuyerOrderIndex].serviceOrderIndex = newOrderIndex;

            return newOrderIndex;
        } else {
 //           if (! msg.sender.send(msg.value)) throw;
            //return 0;
            throw;
       }
    }
    
    function confirmPayment(uint orderIndex) {
        serviceOrder thisOrder = orders[msg.sender][orderIndex];    
        if (thisOrder.buyerAddress == 0) throw;
        if (!thisOrder.available) {
            //Here might have securty issue. We should check solidity secure impelmentation
            //Should change the statu first or send first
            //And if send failed, how to recall the statu
            if (msg.sender.send(thisOrder.payment)) {
                confirmOrder (orderIndex, msg.sender);   
                thisOrder.available = true;
                thisOrder.payment -= thisOrder.payment;
            } else {
                throw;
            }
        }
    }
}
