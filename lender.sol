pragma solidity ^0.4.0;
contract Lender {
    address owner;
    uint maxLendAmount;
    mapping(address => uint) balanceOf;
    
    event Borrowed(address who, uint amount);
    event Returned(address who, uint amount);
    
    function Lender(uint maxAmount) public {
        owner = msg.sender;
        maxLendAmount = maxAmount;
    } 
    
    function changeMaxAmount (uint maxAmount) public {
        if(msg.sender != owner) {
            revert();
        } 
        maxLendAmount = maxAmount;
    }
    
    function requestMoney(uint amount) public {
        if(amount > maxLendAmount && balanceOf[msg.sender] + amount > maxLendAmount) {
            revert();
        } 
        balanceOf[msg.sender] += amount;
        Borrowed(msg.sender, amount);
    }
    
    function returnMoney(address who, uint amount) public {
        if(msg.sender != owner) {
            revert();
        }
        
        if(balanceOf[who] < amount ) {
            revert();
        }
        
        balanceOf[who] -= amount;
        Returned(who, amount);
    }
}
