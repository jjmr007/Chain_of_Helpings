# Chain_of_Helpings

This is a simple mutual credit system combined with Trevor's "pay it forwadr" system.

A main contract incorporates a set of founders. Each founder startswith a CDP which will hold a debt balance of 1 merit.

The contract itself will initially hold a number of positive merits equal to the number of founders.

A CDP can collateralize merits in order to coin credits and is the only valid kind of address to transfer and recive credits, in order to avoid hyperinflation of credits.

Merits however can be freely tranferred as any other ERC20 token.

New members of the helping chain can be added through a new CDP created through the contract by a helper, and assesed by a set of tree escrow agents randomly selected from the already members of the contract chain.



