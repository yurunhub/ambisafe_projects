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
    
    function changeMaxAmount(uint maxAmount) public {
        if(msg.sender == owner) {
            maxLendAmount = maxAmount;
        } else {
            revert();
        }
    }
    
    function requestMoney(uint amount) public {
        if(amount <= maxLendAmount && balanceOf[msg.sender] + amount <= maxLendAmount) {
            balanceOf[msg.sender] += amount;
            Borrowed(msg.sender, amount);
        } else {
            revert();
        }
    }
    
    function returnMoney(uint amount) public {
        if(balanceOf[msg.sender] >= amount ) {
            balanceOf[msg.sender] -= amount;
            Returned(msg.sender, amount);
        } else {
            revert();
        }
    }
}
