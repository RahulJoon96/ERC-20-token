// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface ERC20Interface {
    function totalSupply () external view returns(uint);  
    function balanceOf (address tokenOwner) external view returns(uint balance);
    function transfer (address to, uint tokens) external returns (bool success);
    function allowance (address tokenOwner, address spender) external view returns (uint remaining);
    function approve (address spender,uint tokens) external returns (bool success);
    function transferFrom (address from, address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from,address indexed to,uint tokens);
    event Approval(address indexed tokenOwner,address indexed spender,uint tokens);
}

 contract Block is ERC20Interface {

   string public name ="Block";
   string public symbol ="BLK";
   uint public decimal = 0;
   uint public override totalSupply; 
   address public founder ; 
   mapping (address=>uint) public balances; 
   mapping (address=>mapping (address=>uint)) allowed; 

   
   constructor (){
       totalSupply = 1000;
       founder = msg.sender;
       balances[founder] = totalSupply; 
   }

   
   function balanceOf (address tokenOwner) external view override returns(uint balance){ 
     return balances[tokenOwner];    
   }

   
   function transfer (address to, uint tokens) external override returns (bool success){
       require(balances[msg.sender]>=tokens,"You have insufficient balance");
       balances[to]+= tokens;
       balances[msg.sender]-= tokens;

       emit Transfer(msg.sender, to, tokens);
       return true;   
   }

   function approve (address spender,uint tokens) external override returns (bool success){
      require(balances[msg.sender]>=tokens,"You have insufficient balance");
      require(tokens>0,"Zero no. of tokens can't be approved");
      allowed[msg.sender][spender] = tokens;

      emit Approval(msg.sender, spender, tokens);
      return true;
   }

   function allowance (address tokenOwner, address spender) external view override returns (uint totalAllowed){
      return allowed[tokenOwner][spender];         
   }

   
   function transferFrom (address from, address to, uint tokens) external override  returns (bool success){
      require(allowed[from][to]>=tokens,"You are not approved for this much of tokens");
      require(balances[from]>=tokens,"person sending the tokens do not carry sufficient amount");
      balances[from]-= tokens;
      balances[to]+= tokens;

      return true;
   }
 }
