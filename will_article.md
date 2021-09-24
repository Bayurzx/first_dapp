# Learn: Solidity’s Smart Contract by Creating a Will!

Hello and welcome👋🏼, I am Adebayo😁. I will be creating a crypto based `Will` using a simple smart contract in the Solidity programming language.
This article is based on the [Complete DApp - Solidity & React - Blockchain Development](https://www.udemy.com/course/complete-dapp-solidity-react-blockchain-development/) on Udemy.

## Summary
- Little introduction to writing a smart contract
- Some common feature of solidity
- Inheritance of Will and distribution logic 


If you know anything about blockchain, then you might have heard about one of its applications, smart contracts. Smart contracts, just like regular contracts are like agreements🤝🏼 that become valid/active when a condition is met. But with smart contracts, you can automate the execution of a contract after storing it in blockchain. No middleman, no time-delay, tamper proof and efficient making the contract smart (*Sorry, I could not help it😂*).

One of the most common IDE for writing smart contracts is the [remix](https://github.com/ethereum/remix-ide) IDE hosted on `ethereum.org`. This is the fastest way to get started with writing Smart contracts with solidity. It comes with all you need, a web browser-based compiler and about 15 free Ethereum account loaded with 100eth coin. These coins are on the Testnet not the Mainnet so don't even think of spending them🙄. 


> Hint: You may decide to write you code in VS Code, for easeir editing and copy the code to the remix IDE
> You will find the extension, `Solidity support for Visual Studio code` by Juan Franco very useful. It supports auto-completion syntax highlighting, Snippets and etc.
> There is also the `Ethereum Remix Project extension for Visual Studio Code` extension. It is in beta-release at the moment of the writing. You may test it out.

## Let us dive in by creating our first solidity file. I will be naming it `will.sol`. Solidity files end with the `.sol` extension.

```solidity 
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

contract Will {
  code...
}
```
> Before writing your contract, it is mandatory to state the solidity version as this will determine the version of compiler that compiles the code. You should also insert the `SPDX-License-Identifier` which should be in a comment as a good practice. Checkout a full list of licenses [here](https://spdx.org/licenses/) 

 ```solidity
 contract Will {

   ...code

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

  code...
  
 }
 ```
- We define our three state variables (`owner`, `fortune` and `deceased`) which would be stored in this contract storage. Its is necessary to always state your variable `type` when defining variables in solidity. There are wayyy to many `types` used in solidity. This type affect how a contract interacts with data variable, function etc.

- State, Local, Global variable are the three types of variables in solidity
  - `Local variables` just like in JavaScript are scoped variables, they are often defined in functions and serve out their purpose in the function.
  - `State variables` are defined outside of functions, they are sort of the global variables in JS
  - `Global Variables` are special pre-defined variables that can exist globally across contracts. `msg.sender` is an example of global variables
- Constructors are often used to initialize state variables of a contract and are executed only once, when the contract was created. Read more [here](https://www.tutorialspoint.com/solidity/solidity_constructors.htm)

## Next we created two modifiers, an array and then mapped addresses to amount of inheritance
```
  ...code

    // define modifier functions that only owner can call it
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // function body is inserted where the special symbol "_;" add to functions
    }
    
    // create modifier functions to only allocate funds if deceased
    modifier mustBeDeceased {
        require(deceased == true);
        _; // function body is inserted where the special symbol "_;" add to functions
    }

    // list of family wallets
    address payable [] familyWallets;

    // map through inheritance
    // this enables us to set the inheritance later on
    mapping(address => uint) inheritance;

    code...
```

- Modifier Functions are sort of conditions that will allow another function to run if true. It works well with `require()` or `if statement`. 
  - With `require` you can add a string as a second argument to be outputted when the condition is not met

- You create list in Solidity by indicating the square bracket ahead of its name like this:  `[] familyWallets;`. In this example, we indicated the types:  `address` and `payable`. 
  - This ensures that the content is Ethereum addresses and allows for payment respectively

- Mapping helps us to pair `_key` and `_value` data. This is like `objects data type` in JavaScript.

``` solidity
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

```

- The setInhertiance function receives two arguments `wallet` and `amount`
  - As you may have noticed, wallet has two types `payable` and `address` while `amount` has `uint`(unsigned integer) type aka `uint32`
- We then push each `wallet` into the list(familyWallet) created earlier and designate an `amount` to be inherited
- The `payout` simply loops each `wallet` in family wallet and transfers the corresponding amount`(mapping)`: `<wallet.transfer(amount)>`
- Notice the two lines of code commented under `//or`, its an alternative to `transfer` method. The `transfer` method is sometimes avoided because of the hard dependency on gas costs. Read up on this here and [here](https://ethereum.stackexchange.com/questions/78124/is-transfer-still-safe-after-the-istanbul-update/78136#78136) 
  <!-- - `(bool success, )` checks to see if transfer was successful else returns "Transfer failed" -->
  Note that the visibility is set to private. private is one of the four common visibility type [Public, private, internal, external] It ensures that the function is not called outside the contract

```solidity
      // oracle switch simulation
    function payWill() public onlyOwner {
        deceased = true;
        payout();
    }
```

`paywill` function enables us to call the `payout` function whose visibility was set to `private` after i ensured that the `onlyOwner` and `mustBeDeceased` conditions are met.

## Here is where things start to get interesting, Let's run the contract in our [remix IDE](https://remix.ethereum.org/)
[!compile]()
