pragma solidity ^0.5.12;

library ContractStt {
    
        /*
    *   it gives:
    *   any total balance of the contract;
    *   any merit parameter according to an index (Value in credits, % of collateral, minimum quorum);
    *   if an address contract is an allied master store contract;
    *   an allied address by the array index;
    *   how many alliances there are;
    *
    *   it allows:
    *   set any total balance by index;
    *   set the whole array of merit parameters;
    *   set a new alliance (bridge);
    */
    
    struct ContractState {
    
    uint256[6]  _Sums;
    /*    
    uint256 _Reference;
    uint256 _BlocdMrts;
    uint256 _TotalDebt;
    uint256 _FreeMerits
    uint256 _TotalPendings;
    uint256 _TotalCredits;
    */
    
    uint256[3]  _X; // _X[0] is value of merits in credits, _X[1] is % valid collateral, _X[2] is minimum quorum (Governance)
    mapping(address => bool) _Bridges;
    address[]   _BRdgs; 
    
    }

    function GetTotals(ContractState storage cs, uint8 b) internal view returns(uint256) {
        
        require (b < 6, "Not a valid register");
        return cs._Sums[b];
        
    }
    
    function SetNetValue(ContractState storage cs, uint8 b, uint256 newTotal) internal {
        
        require ((b < 6 && b != 0), "Not a valid register");
        cs._Sums[b] = newTotal;
        
    }

    function GetMeritValues(ContractState storage cs, uint8 i) internal view returns(uint256) {
        
        require (i < 3, "Not a valid register");
        return cs._X[i];
        
    }
    
    function SetMeritValues(ContractState storage cs, uint256[3] memory X) internal {
        
        cs._X = X;
        
    }

    function BridgebyID(ContractState storage cs, uint256 i) internal view returns(address) {
        
        require(cs._BRdgs.length > i, "that bridge number does not exist");
        return cs._BRdgs[i];
        
    }
    
    function SetBridge(ContractState storage cs, address a) internal {
        
        require(!cs._Bridges[a]);
        cs._Bridges[a] = true;
        cs._BRdgs.push(a);
        
    }

}
