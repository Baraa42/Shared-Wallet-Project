// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    event AllowanceChanged(address indexed _forwho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    
    mapping(address => uint) public allowance;
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    modifier ownerAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "you are not allowed");
        _;
    }
    
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    function reduceAlowance(address _who, uint _amount) internal {
        emit AllowanceChanged(_who, msg.sender, allowance[_who],allowance[_who]- _amount);
        allowance[_who] -= _amount;
    }
}
