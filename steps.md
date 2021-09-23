# Will
## Create a will for the deceased using solidity

- Learn't about modifier functions
  - Incorporated a "if" statement using the `require` function

- Create list of wallets with `[] familyWallets` added types `address` and `payable`
  - This list enables us to pay all family members at one
- mapping allows us to map `_keys` to `_values` just like objects in `JS`
- `setInheritance` function accepts two args `[wallet and amount]` and...
  - first, pushes wallet recieved to a list
  - second, maps amount recieved to the wallet pushed 

- The main function `payout` pays all wallets in the `familyWallet` the amount mapped to it at once
  - It has the a pre-defined condition `mustBeDeceased` which ensures that the `deceased` bool variable is true
  - Uses the famous `transfer` solidity method to transfer to wallets in a loop
    - `familyWallet[i]` is a single wallet we transfer to
    -  `inheritance[familyWallets[i]]` is the amount we transfer
       -  Remember that inheritance is a `key=>value`; `wallet=>amount` pair
-  the payout function was set to private, so to access `payout` function we create another function called `payWill`which is public
   -  `payWill` has the `onlyOwner` pre-defined condition and sets `deceased` to true to allow `mustBeDeceased` condition

# Subcurrency
