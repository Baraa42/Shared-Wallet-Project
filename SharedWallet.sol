// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "./Allowance.sol";

contract SharedWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function withdrawMoney(address payable _to, uint _amount) public ownerAllowed(_amount)  {
        require(address(this).balance >= _amount, "not enough funds");
        if(!isOwner()){
            reduceAlowance(msg.sender, _amount);
        }
        
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
        
    }
    
    function renounceOwnership() public override onlyOwner {
        revert("Cant renounce ownership here");
    }
   
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
        
    }
}
