pragma solidity ^0.4.24;

contract donations{
    address owner=0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    
    function donate() public payable{}
    
    function withdraw() {
        if(msg.sender == owner) {
            msg.sender.transfer(this.balance);
        }
    }
}
