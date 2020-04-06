pragma solidity ^0.6.0;
contract bank{
    mapping (string => address)public students; 
    mapping (address => user)public balances; 
    struct user{
        int256 money;
        int256 num_of_trans;
        uint last_trans_time;
        bool is_exits;
    }
    address payable public owner; 
    address payable public bank_address;
    
    
    function deposit()public payable{
        require(balances[msg.sender].is_exits == true ,'你沒有申請銀行');
        //owner .transfer(msg.value);
        balances[bank_address].money += int256(msg.value);
        balances[msg.sender].money += int256(msg.value);
        balances[msg.sender].last_trans_time = now;
        balances[msg.sender].num_of_trans += 1 ;
            
        
    }
    

    function withdraw(int  withdrawAmount) public  returns(int256){
        require( balances[owner].money  >=withdrawAmount,'你銀行的錢不夠');
        msg.sender .transfer(uint256(withdrawAmount));
        // balances[owner].money -= int256(withdrawAmount);
        balances[bank_address].money += int256(withdrawAmount);
        balances[msg.sender].money += int256(withdrawAmount);
        balances[msg.sender].last_trans_time = now;
        balances[msg.sender].num_of_trans += 1 ;

            
            
    }
    

    function transfer(int transerAmount, address payable stduentAddress)public payable{
        require( balances[owner].money  >= transerAmount,'你所要轉的錢不夠');
        balances[msg.sender].money -= int256(transerAmount);
        balances[stduentAddress].money += int256(transerAmount);
        balances[msg.sender].last_trans_time = now;
        balances[msg.sender].num_of_trans += 1 ;
        
    }
    

    function getBalance()external view  returns(int256){
        return balances[msg.sender].money;
    }
    

    function getBankBalance() external view  returns(int256){
        require(owner == msg.sender ,'你沒有權限');
        return balances[owner].money;
        
    }

    function enroll(string memory stduentId)public{
        students[stduentId] = msg.sender;
        balances[msg.sender].is_exits = true;
        
    }
    

    fallback() external{
        require(owner == msg.sender ,'No');
        selfdestruct(owner);
    }
    
    constructor() public{
        owner = msg.sender;
    }
    
}