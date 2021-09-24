// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

contract Will {
    // define variables
    address owner;
    uint fortune;
    bool deceased;
    
    constructor() payable {
        // set variables
        owner = msg.sender; // represents address called
        fortune = msg.value; // how much ether is being represents
        deceased = false;
    }
    
    // create modifier functions so only owner can call it
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // function body is inserted where the special symbol "_;"
    }
    
    // create modifier functions to only allocate funds if gramps is deceased
    modifier mustBeDeceased {
        require(deceased == true);
        _; // function body is inserted where the special symbol "_;"
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
            // familyWallets[i].transfer(inheritance[familyWallets[i]]);
            // or
            (bool success, ) = familyWallets[i].call{value:inheritance[familyWallets[i]]}("");
            require(success, "Transfer failed.");

        }
    }

    // oracle switch simulation
    function payWill() public onlyOwner {
        deceased = true;
        payout();
    }

}