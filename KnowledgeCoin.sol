pragma solidity 0.4.24;


contract Token {
  string private constant symbol = 'KNC';
  uint256 private constant value = 1;
  uint256 needtograduate = 12;
  string[] private courses;//holds all the names of the courses (shown in dropdown menu for teacher to choose)
  string public constant name = 'Knowledgecoin';
  uint public constant rate = 0;  // rate of token / wei for purchase
  uint256 private totalSupply_;
  mapping (address => uint256) public balances_;//maps the address to the balance.
  //mapping (address => uint256) public checkoutmap_;//maps the address to the valid checkou time
  //creates a reference to know that a specific address (account) has a specific blance.
  mapping(address => bytes32[]) public coursestaken;//stores the courses that student at specific address is taking
  mapping(address => bytes32[]) public description;//the student to the course descriptions (in the same order as the courses are stored in the coursestaken map)
  //mapping(string=> string) public displaycourse;//
 // mapping(address =>bool) public bigmapkeyexists;
 // address[] private bigmapkeys;
  //string[] private nestedmapkeys;

  event Transfer(address indexed from, address indexed to, uint value);
  event TokensMinted(address indexed to, uint256 value, uint256 totalSupply);
  event Erase (address indexed from, uint value); 
    
  constructor() {}

  // Buy tokens with ether, mint and allocate new tokens to the purchaser.
    
    
    //Return total amount of tokens
    function totalSupply() external constant returns (uint256) {
        return totalSupply_; 
    }
    
    //Return the address' balance 
    function balanceOf(address _owner) public returns (uint256) {
        return balances_[_owner];
    }
    
    function canGraduate(address student) public returns(bool){
      if(balanceOf(student) >= needtograduate){
        return true;
      }
      return false;
    }
    
    function getCourse(address student) external returns (bytes32[]){
        return coursestaken[student];
    }
    
    function getDescription(address student) public returns (bytes32[]){
        return description[student];
    }


  function addcourse(address student, bytes32 coursename, bytes32 _description) public payable returns (bool)//creates new tokens (balance increases by 1 every time it is called)
  {
    totalSupply_ += value;   // NOTE overflow
    balances_[student] += value; // NOTE overflow adding to the balances
    coursestaken[student].push(coursename);//update the courses
    description[student].push(_description);//update the description 
    //coursestaken and description are parallel (their elements at specific indexes are related)
    emit TokensMinted(msg.sender, msg.value, totalSupply_);
    return true;
  }
  
  
}
