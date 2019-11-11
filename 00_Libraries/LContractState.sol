pragma solidity ^0.5.12;

library ContractStt {
    
    struct ContractState {
        
    uint256 _Reference;                                             // 1.-accessible from helpings
    uint256 _TotalMembers;                                          // 2.-view from helpings
    uint256 _BlocdMrts;                                             // 3.-view from Merits
    uint256 _TotalDebt;                 // view from credits
    uint256 _FreeMerits;                // erc20 Merits; balance of
    uint256 _TotalPendings;             // erc20 Pendings; balance of
    uint256 _TotalCredits;              // erc20 Credits; balance of
    
    uint256[3]  _X; // _X[0] is value of merits in credits, _X[1] is % valid collateral, _X[2] is minimum quorum (Governance)
    address[]   _Members;                                           // 4.-view from helpings
    mapping(address => bool) _Bridges;                              // 5.-view from helpings
    address[]   _BRdgs; // in case of migration a register of bridges is allways necessary
    
    address _Principal;                 
    address _ERC20_Merits;                                          // 6.-view from helpings
    address _ERC20_Pendings;                                        // 7.-view from helpings
    address _ERC20_Credits;                                         // 8.-view from helpings
    address _Govern;                                                // 9.-view from helpings
    address _Migrate;   // if this address is NOT zero (0x00...00)    10.-view from helpings
                        //is both, a flag and the destination of the new contract version
        
    }

    function CreationTime(ContractState storage cs) internal view returns(uint256) {
        
        return cs._Reference;
        
    }
    
    function Members(ContractState storage cs) internal view returns(uint256) {
        
        return cs._TotalMembers;
        
    }

    function FreezedM(ContractState storage cs) internal view returns(uint256) {
        
        return cs._BlocdMrts;
        
    }

    function NetDebt(ContractState storage cs) internal view returns(uint256) {
        
        return cs._TotalDebt;
        
    }

    function NetMerits(ContractState storage cs) internal view returns(uint256) {
        
        return cs._FreeMerits;
        
    }

    function NetPendings(ContractState storage cs) internal view returns(uint256) {
        
        return cs._TotalPendings;
        
    }

    function NetCredits(ContractState storage cs) internal view returns(uint256) {
        
        return cs._TotalCredits;
        
    }

    function MeritValues(ContractState storage cs, uint8 i) internal view returns(uint256) {
        
        return cs._X[i];
        
    }

    function MemberbyID(ContractState storage cs, uint256 i) internal view returns(address) {
        
        return cs._Members[i];
        
    }

    function isBridge(ContractState storage cs, address a) internal view returns(bool) {
        
        return cs._Bridges[a];
        
    }

    function BridgebyID(ContractState storage cs, uint256 i) internal view returns(address) {
        
        return cs._BRdgs[i];
        
    }

    function Home(ContractState storage cs) internal view returns(address) {
        
        return cs._Principal;
        
    }

    function MeritERC20(ContractState storage cs) internal view returns(address) {
        
        return cs._ERC20_Merits;
        
    }

    function PendERC20(ContractState storage cs) internal view returns(address) {
        
        return cs._ERC20_Pendings;
        
    }

    function CreditERC20(ContractState storage cs) internal view returns(address) {
        
        return cs._ERC20_Credits;
        
    }

    function GovernAddr(ContractState storage cs) internal view returns(address) {
        
        return cs._Govern;
        
    }

    function MigratingTo(ContractState storage cs) internal view returns(address) {
        
        require (cs._Migrate != address(0), "Not in a Migration Process");
        return cs._Migrate;
        
    }

}
