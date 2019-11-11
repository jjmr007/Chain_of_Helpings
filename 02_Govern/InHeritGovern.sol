pragma solidity ^0.5.12;

import { gObjects as _GO } from "./LgObjects.sol";

contract Govern {

    using _GO for _GO.Votes;

    _GO.Votes internal _V;

    function MeritValue(uint8 i) public view returns(uint256) {
        
    }
    
    function ActiveProposals(uint8 kind) public view returns(uint256) { }
    
    function CheckProposal(bytes memory Serialized, bytes32 hash) public view returns(bool) {  }
    
    function CommitMeritValue(bytes32 x) public returns (bool) { }
    
    function PunishMeritValue(uint256[3] memory _x, string memory _s, address _a) 
    public returns (bool) { }
    
    function SetMeritValue(uint256[3] memory _x, string memory _s) 
    public returns (bool) { }

    
    function SetProposal(uint256 Budget, bytes32 HashProposal, address PropOwner) public returns (bool) {
        
    }
    
    function HelpProposal(uint256 Value, bytes32 HashProposal, address PropOwner) public returns (bool) {
        
    }
    
    function RemoveMember(address Member, address PropOwner) public returns (bool) {
        
    }
    
    function BridgeProposal(address OtherChain, bool SetORremove, address PropOwner) public returns (bool) {
    
    }
    
    function ImproveProposal(address NextContract, address PropOwner) public returns (bool) {

    }
    
    function CommitProposalVote(bytes32 x, bytes32 hashProposal) public returns(bool)   { }
    
    function PunishProposalVote(bool u, string memory s, bytes32 hashProposal, address a) 
    public returns (bool) { }
    
    function SetProposalVote(bool u, string memory s, bytes32 hashProposal) public returns(bool)   { }
    
    function SetBudget(bytes32 h) public returns (bool) { }
    
    function SetHelp(bytes32 h) public returns (bool) { }
    
    function MemberOut(bytes32 h) public returns (bool) { }
    
    function BridgeChange(bytes32 h) public returns (bool) { }
    
    function MigrationOn(bytes32 h) public returns (bool) { }
    
    function CalcHash(uint256 x, string memory s) public pure returns (bytes32) { 
        
        return keccak256(abi.encodePacked(x + uint256(sha256(bytes(s)))));
        
    }

}
