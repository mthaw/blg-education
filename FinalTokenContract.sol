pragma solidity 0.4.24;

contract Token {
    uint256 private constant pri=11;
    uint256 private constant mid=14;
    uint256 private constant sec=18;
    uint256 private constant primary = 20;
    uint256 private constant middle = 40;
    uint256 private constant secondary = 80;

    string public constant symbol = 'CCO';
    string public constant name = 'Cambocoin';
    uint256 private totalSupply_;
    uint256[] private item;
    
    mapping (address => uint256) private age; //maps the address to the student to the age of the students
    mapping (address => uint256) public balances_;//maps the address to the balance.
    mapping (address => uint256) private checkoutmap_;//maps the address to the valid checkout time
    //creates a reference to know that a specific address (account) has a specific balance.
  
    event Transfer(address indexed from, address indexed to, uint value);
    event TokensMinted(address indexed to, uint256 value, uint256 totalSupply);
    event Erase (address indexed from, uint value);
    
    //initializes the students ages and links it to the addresses
    function initializeAges(address[] a, uint[] b) {
        age[a[0]]=b[0];
        age[a[1]]=b[1];
        age[a[2]]=b[2];
        age[a[3]]=b[3];
        age[a[4]]=b[4];
        age[a[5]]=b[5];
        age[a[6]]=b[6];
        age[a[7]]=b[7];
        age[a[8]]=b[8];
        age[a[9]]=b[9];
    }
    
    //sets up items to be used
    function items() private {
        item[0]=3; //chicken
        item[1]=2; //rice
        item[2]=9; //apple
        item[3]=4; //potatos
        item[4]=25; // beef
        item[5]=3; //onion
        item[6]=4; // tomato
        item[7]=100; //money
        item[8]=300; //health
    }
    
    //Return total amount of tokens
    function totalSupply() private constant returns (uint256) {
        return totalSupply_; 
    }
    
    //Erase token from circulation
    function buyItem(uint256 i) external returns (bool) {
        uint256 _value;
        _value=item[i];
        require(balances_[msg.sender] >= _value, 'Sender balance is insufficient, Token.transfer()');
        balances_[msg.sender] -= _value;
        totalSupply_ -= _value;
        emit Erase(msg.sender, _value); 
        return true;
    }
    
    function checkin(address student) returns (bool){
    uint256 time= now;
    uint256 timeout= time + 10 seconds;
    checkoutmap_[student]=timeout; 
    return true;
}

    function checkout(address student) returns (bool){
    uint256 time = now;
    require(checkoutmap_[student] <= time);
    if(checkoutmap_[student]<= time){
        //you have to let them checkout and give them the tokens for their levels
        if(age[student]<=pri){
            primarymint(student);
        }
        else if(age[student]<=mid){
            middlemint(student);
        }
        else{
          secondarymint(student);  
        }
        delete checkoutmap_[student];
    }
}

    function primarymint(address student) private/*creates new tokens (balance increases by 1 every time it is called)*/{
    totalSupply_ += primary;   // NOTE overflow
    balances_[student] += primary; // NOTE overflow
    emit TokensMinted(msg.sender, msg.value, totalSupply_);
  }

    function middlemint(address student) private/*creates new tokens (balance increases by 1 every time it is called)*/{
    totalSupply_ += middle;   // NOTE overflow
    balances_[student] += middle; // NOTE overflow
    emit TokensMinted(msg.sender, msg.value, totalSupply_);
  }

    function secondarymint(address student) private/*creates new tokens (balance increases by 1 every time it is called)*/{
    totalSupply_ += secondary;   // NOTE overflow
    balances_[student] += secondary; // NOTE overflow
    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    }
}
