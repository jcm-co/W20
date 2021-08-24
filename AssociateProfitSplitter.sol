pragma solidity ^0.5.0;


// lvl 1: equal split
contract AssociateProfitSplitter {
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c

    address payable employee_one;
    address payable employee_two;
    address payable employee_three;
    uint public individualDeposit;
    uint public remainingBalance;
    uint public employeeOneBalance;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {

        // @TODO: Split `msg.value` into three
        individualDeposit = msg.value/3;
        
        // // @TODO: Transfer the amount to each employee
        employee_one.transfer(individualDeposit);
        employee_two.transfer(individualDeposit);
        employee_three.transfer(individualDeposit);
        
        employeeOneBalance = employee_one.balance;

    // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
       
        remainingBalance = msg.value - (individualDeposit*3);
        if(remainingBalance >=0) {msg.sender.transfer(remainingBalance);}
    }

    function() external payable {
    // @TODO: Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}
