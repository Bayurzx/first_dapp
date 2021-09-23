// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// contract allows only the creator to create new coins
// anyine can send coins without authentication

contract Coin {
    // define variables
    address public minter;
    address (address => uint) public balances;
    
    constructor() payable public {
        // set variables
        minter = msg.sender; // represents address called
        fortune = msg.value; // how much ether is being represents
        deceased = false;
    }
    
    // create modifier functions so only owner can call it
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // creates a modifier(that acts as if statements) that we can add to funcitons
    }
    
    // create modifier functions to only allocate funds if gramps is deceased
    modifier mustBeDeceased {
        require(deceased == true);
        _; // creates a modifier(that acts as if statements) that we can add to funcitons
    }
    
    // list of family wallets
    address payable [] familyWallets;

    // map through inheritance
    // this enables us to set the inheritance later on
    mapping(address => uint) inheritance;

    // set inheritance for each address basically by attributing the amount to address

    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        // add wallet to the family wallets
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // pay each family based on their wallet address

    function payout() private mustBeDeceased {
        for (uint256 i = 0; i < familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch simulation
    function payWill() public onlyOwner {
        deceased = true;
        payout();
    }

}