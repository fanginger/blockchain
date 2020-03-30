pragma solidity ^0.6.0;
contract bank{
    mapping (string => address)public students; //學號映射到地址
    mapping (address => int256)public balances; //地址映射到存款金額
    address payable public owner; //銀行的擁有者，會在constructor做設定
    //可以新增的東西：1.交易次數 2.time
   //可以讓使用者call這個函數把錢存進合約地址，並且在balances中紀錄使用者的帳戶金額
    function deposit()public payable{
        owner .transfer(msg.value);
        balances[owner] += int256(msg.value);
    }
    
    //可以讓使用者從合約提錢，這邊需要去確認合約裡的餘額 >= 想提的金額
    // function withdraw(uint  withdrawAmount)public view payable{
    function withdraw(uint  withdrawAmount) public  returns(int256){
         if (owner.balance >= withdrawAmount){
            //  .transfer(withdrawAmount);
            balances[owner] -= int256(withdrawAmount);
            balances[msg.sender] += int256(withdrawAmount);
            // return owner.balance;
         }
         else{
            selfdestruct(owner);
         }
            
            
            
    }
    
    //可以讓使用者從合約轉帳給某個地址，這邊需要去確認合約裡的餘額 >= 想轉的金額
    //實現的是銀行內部轉帳，也就是說如果轉帳成功balances的目標地址會增加轉帳金額
    function transfer(uint transerAmount, address payable stduentAddress)public payable{
        if (owner.balance >= transerAmount){
            stduentAddress .transfer(transerAmount);
            //如果你在合約裡面寫 address.transfer(1 ether)他是會從合約轉1 ether給address。
            balances[owner] -= int256(transerAmount);
            balances[stduentAddress] += int256(transerAmount);
        }
        
    }
    
    //從balances回傳使用者的帳戶餘額
    function getBalance()external view  returns(int256){
        return balances[msg.sender];
    }
    
    //回傳銀行合約的所有餘額，設定為只有owner才能呼叫成功
    function getBankBalance() external view  returns(int256){
        require(owner == msg.sender ,'你沒有權限');
        return balances[msg.sender];
        
    }
    //透過students把學號映射到使用者的地址
    function enroll(string memory stduentId)public{
        students[stduentId] = msg.sender;
    }
    
    //當觸發fallback時，檢查觸發者是否為owner，是則自殺合約，把合約剩餘的錢轉給owner
    fallback() external{
        require(owner == msg.sender ,'No');
        selfdestruct(owner);
    }
    
    //設定owner為創立合約的人
    constructor() public{
        owner = msg.sender;
    }
    
}