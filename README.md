# Chain_of_Helpings

This is a simple mutual credit system combined with the system proposed by Catherine Ryan Hyde that she explains in her novel: "Pay it Forward".

A main contract incorporates a set of founders. Each founder starts with a CDP which will hold a debt balance of 1 merit.

The contract itself will initially hold a number of positive merits equal to the number of founders.

A CDP can collateralize merits in order to coin credits and is the only valid kind of address to transfer and recive both merits and credits, in order to avoid an hyperinflation attack with these coins.

New members of the helping chain can be added through a new CDP created through the contract by a helper, and assesed by a set of three escrow agents randomly selected from the already members of the contract chain. Ussualy new members are incorporated because they have received a relevant help.

Escrow agents must decide if this new CDP is justified. They must ust suggest the measures to complete the help in a way that significantly improves the life of the receiver. The receiver must agree with the help. In the case that the CDP proposal is rejected the new CDP is deleted.

Once the favor is done the help receiver releases the coins with a balance of a positive merit for the helper's CDP, 1/3 of merit for CDPs of each escrow agents and 1 merit for the main contract; and minus three merits in the CDP of the receiver. If the receiver refuses to release after certain time window, the escrow agents can proceed to decide. If the decision is to release, the CDP is confirmed with the ending refered balances. Otherwise, the CDP is deleted. The 1/3 positive balances of aditional merits will always be paid to the escrow agents.

In order to coin credits, the CDP owner can lock any positive balance of merits. The amount of credits must be less or equal to the value in credits of the positive merits balance, which value is set by the governance system of the main contract.

Initially this value is proposed as 12.000 credits for each merit.

The main contract will dispose a bridge mechanism in order to accept credits from other chains; this bridges must be approved by the governance system. But this bridge must exist also in the other contract, in order to authorize the other chain to make changes on the other's credit balance map. Otherwise transactions between chains are reverted.

Certain chain can disconnect from another chain, through the governance system, but once the desicion is taken, the change can only be applied by the contract if the amount of circulating credits of that chain is equal or greater than the net value of all locked merits.  Once a bridge is set, it is supposed it must last.

In the unfortunate case of a chain that breks their bridge to another chain, and the ending balance of the net supply of credit tokens surpases the net value of merit locked, a flag of "pause" must be rised, and the coinage of credits must be suspended until the situation turns back to normality: less net circulating credits than the value locked merits.

Migrations to another contract are a complex issue, but it can be trusted in part to each CDP owner, by making the migration effective for this user the next time a transaction is done from a CDP.

### CDPs

The main function of a CDP is to allow the transfer of tokens, specially merits and credits involved in this system. These contracts may be allowed to hold ethers but the standard will be not to make such complication.

One storage variable of this contract will be the owner address, the only authorized to make transfers from this contrac. The main contract will store a struct of maps, correlating CDP's addresses with its merits (positive balances of merits) and pendings (negative balances of merits). It would be easier to use integer numbers with sign, but that would make these contracts would be ERC20 non compatibles.

Other storage variable may be a flag indicating the locking of some positive merit balance, although this can olso be managed by the main contract, the same way "allowances" are addressed in ERC20 tokens.

Another important function will be a receiver for tokens. A CDP will only receive allowed credits, i.e. credits coined by the native chain or other chains the contract has bridged with. When an allowed credit is received, the CDP checks its credit balance and takes the difference between amount of credit and the balance whether positive or negative, registering the remaining balance in terms of the native credit token.

In order to have only one kind of balance, unlocked merits must merge with negative merits or pendings, if the CDP is object of a future receiving helping. A CDP with newly received pendings (negative merits) can not collateralize until these favours are paid. If a debt position is paid under this condition, the positive merits unlocked must automatically merge with the pendings.

