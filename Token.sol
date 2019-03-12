pragma solidity 0.4.24;


contract Token {
  string private constant symbol = 'CCO';
  
  uint256 private constant primary = 0;
  uint256 private constant middle = 0;
  uint256 private constant secondary = 0;

  string public constant name = 'Cambocoin';
  uint public constant rate = 0;  // rate of token / wei for purchase
  uint256 private totalSupply_;
  mapping (address => uint256) public balances_;//maps the address to the balance.
  mapping (address => uint256) public checkoutmap_;//maps the address to the valid checkout time
  //creates a reference to know that a specific address (account) has a specific blance.
  
  event Transfer(address indexed from, address indexed to, uint value);
  event TokensMinted(address indexed to, uint256 value, uint256 totalSupply);
  event Erase (address indexed from, uint value); 
    
  constructor() {}

  // Buy tokens with ether, mint and allocate new tokens to the purchaser.
    
    
    //Return total amount of tokens
    function totalSupply() external constant returns (uint256) {
        return totalSupply_; 
    }
    
    //Erase token from circulation
    function transfer(uint256 _value) external returns (bool) {
        require(balances_[msg.sender] >= _value, 'Sender balance is insufficient, Token.transfer()');
        
        balances_[msg.sender] -= _value;
        totalSupply_ -= _value;
        
        emit Erase(msg.sender, _value); 
        
        return true;
    }
    
    //Return the address' balance 
    function balanceOf(address _owner) external constant returns (uint256) {
        return balances_[_owner];
    }
    
function checkin(address student) returns (bool)
{
    uint256 time= now;
    uint256 timeout= time + 10 seconds; //modify time from 10 seconds
    checkoutmap_[student]=timeout; 
    return true;
}

function checkout(address student) returns (bool){
    uint256 time = now;

    require(checkoutmap_[student] <= time);

    if(checkoutmap_[student]<= time){
        //you have to let them checkout and give them the tokens for their levels
        primarymint(student);
        delete checkoutmap_[student];
    }
}


  function primarymint(address student) public payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    //require(msg.value > 0, 'Cannot buy with a value of <= 0, Token.buy()');
    //uint256 tokenAmount = msg.value * rate;
    totalSupply_ += primary;   // NOTE overflow
    balances_[student] += primary; // NOTE overflow

    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }

  function middlemint(address student) external payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    //require(msg.value > 0, 'Cannot buy with a value of <= 0, Token.buy()');
    //uint256 tokenAmount = msg.value * rate;
    totalSupply_ += middle;   // NOTE overflow
    balances_[student] += middle; // NOTE overflow

    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }

  function secondarymint(address student) external payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    //require(msg.value > 0, 'Cannot buy with a value of <= 0, Token.buy()');
    //uint256 tokenAmount = msg.value * rate;
    totalSupply_ += secondary;   // NOTE overflow
    balances_[student] += secondary; // NOTE overflow

    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }

  // Transfer value to another address
  /*function transfer (a
    address _to,
    uint256 _value
  ) external
    returns (bool)
  {
    require(balancpragma solidity ^0.4.24;


contract Token {
  string public constant symbol = 'CCO';
  
  uint256 private constant primary = 0;
  uint256 private constant middle = 0;
  uint256 private constant secondary = 0;

  string public constant name = 'Cambocoin';
  uint public constant rate = 0;  // rate of token / wei for purchase
  uint256 private totalSupply_;
  mapping (address => uint256) public balances_;//maps the address to the balance.
  //creates a reference to know that a specific address (account) has a specific blance.
  
  event Transfer(address indexed from, address indexed to, uint value);
  event TokensMinted(address indexed to, uint256 value, uint256 totalSupply);

  constructor() {}

  // Buy tokens with ether, mint and allocate new tokens to the purchaser.
  

  function primarymint() external payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    //require(msg.value > 0, 'Cannot buy with a value of <= 0, Token.buy()');
    //uint256 tokenAmount = msg.value * rate;
    totalSupply_ += primary;   // NOTE overflow
    balances_[msg.sender] += tokenAmount; // NOTE overflow

    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }

  function middlemint() external payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    //require(msg.value > 0, 'Cannot buy with a value of <= 0, Token.buy()');
    //uint256 tokenAmount = msg.value * rate;
    totalSupply_ += middle;   // NOTE overflow
    balances_[msg.sender] += tokenAmount; // NOTE overflow

    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }

  function secondarymint() external payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    //require(msg.value > 0, 'Cannot buy with a value of <= 0, Token.buy()');
    //uint256 tokenAmount = msg.value * rate;
    totalSupply_ += secondary;   // NOTE overflow
    balances_[msg.sender] += tokenAmount; // NOTE overflow

    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }

  // Transfer value to another address
  /*function transfer (a
    address _to,
    uint256 _value
  ) external
    returns (bool)
  {
    require(balances_[msg.sender] >= _value, 'Sender balance is insufficient, Token.transfer()');

    balances_[msg.sender] -= _value;  // NOTE underflow
    balances_[_to] += _value;  // NOTE overflow

    emit Transfer(msg.sender, _to, _value);

    return true;
  }*/
}
