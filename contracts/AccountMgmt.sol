// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract AccountMgmt{
  
      
    event Deposit(address indexed accountAddress, uint amount);   //event  log of deposit which has two arguments(deposit made by address and amount)
                                                                 //Indexing can be used for filtering the events for specific values 
    
     enum gender {          //create enum to have predefined values for gender
         MALE,
         FEMALE,
         OTHER
     }

        
    struct ActDetails {   //create struct to save account details
    
        string fName;
        string lName;
        int8 age;
        gender Gender;
        Address addr;
        bool verify;        //use verify of bool type to "verify" if user has been added or not
    }
    
      struct Address{       //create struct to store account holder adress
    
        string line1;
        string line2;
        string city;
        string state;
        int256 pincode;
        
    }





    mapping(address => ActDetails)  accounts;    //mapping of struct to save user details via their address
     mapping (address => uint)  balances;        //mapping of address to corresponding value of uint

    function createUser( string memory _fName, string memory _lName, int8 _age, gender _gender, string memory _line1, string memory _line2, string memory _city, string memory _state, int256 _pincode  ) public 
    { 
        ActDetails memory acc = ActDetails(       //Initialize struct in solidity
            {
            
          
                
                fName: _fName,
                lName: _lName,
                age: _age,
                Gender: _gender,
            addr: Address(
                {
                line1: _line1,
                line2: _line2,
                city: _city,
                state: _state,
                pincode: _pincode
                    
                }),
            verify:true                     //user account created
        });
        accounts[msg.sender]=acc;           //access acc using mapping
    }
    
    
    //<--------------------------------------------------------------------------------------------------------------------------------->
    
    //DEPOSIT AND WITHDRAW BALANCE
    
    
      function balance() public view returns (uint) {     //read and return the balance of the account
        return balances[msg.sender];                     // read-only function, cannot modify the state
    }

    function deposit() public payable onlyadmin returns (uint) {      //function to deposit ethereum to account
        balances[msg.sender] += msg.value;                 
        emit Deposit(msg.sender, msg.value);                //emit the deposit event whuch takes two argument address of owner(who is sending the transaction)
                                                            // and msg.value(amout of wei sent in the transaction)            
        return balances[msg.sender];                                    
    }


 
 
       function withdraw(uint Amount) public payable onlyadmin returns (uint remainingBal) {
        
        if (Amount <= balances[msg.sender]) {        // Check enough balance available, otherwise just return balance
            balances[msg.sender] -= Amount;                  //deduct the amount
            msg.sender.transfer(Amount);                    //sending amount  from the smart contract to the sender address
        }
        return balances[msg.sender];                        //If enough balance is not availiable then this condition will execute 
                                                             //which just return balance
    }
    
    
    //<--------------------------------------------------------------------------------------------------------------------------------->//
    
    
    //CHANGE USER details
    
    
    function changeFName(string memory _fname) public onlyadmin {
       accounts[msg.sender].fName =_fname ;

       
    }
    
    function changeLName(string memory _lname) public onlyadmin {
       accounts[msg.sender].lName =_lname ;
       
    }
    
    function changeAge(int8 _age) public onlyadmin{
       accounts[msg.sender].age =_age ;
       
    }
    
    function changeGender(gender _gender) public onlyadmin {
       accounts[msg.sender].Gender=_gender ;
       
    }
    
    function changeAddress(string memory _line1, string memory _line2, string memory _city, string memory _state, int256  _pincode) public onlyadmin {
      Address memory _addr = Address({
          line1:_line1,
               line2:_line2,
               city:_city,
               state:_state,
               pincode:_pincode
      });
      accounts[msg.sender].addr = _addr;
       
    }
        modifier onlyadmin(){
        require(accounts[msg.sender].verify==true);
        _;
    }
    

}