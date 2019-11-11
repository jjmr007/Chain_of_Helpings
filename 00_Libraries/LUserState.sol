pragma solidity ^0.5.12;

import { ContractStt as CS } from "./LContractState.sol";

import { SafeMath } from "./LSafeMath.sol";

library UserStt {
    
    using CS for CS.ContractState;
    using SafeMath for uint256;
    
    struct UserState {
        
        bool    _member;
        uint256 _BlockM;
        uint256 _Debt;
        uint256 _Merit;
        uint256 _Pending;
        uint256 _Credit;
    // address[2]  _AlliedChains;

    }

    struct  _us {
        
        mapping (address => UserState)  _userState;
        
    }
    
    function isMember(_us storage us, address a) internal view returns(bool) {
        
        return us._userState[a]._member;
        
    }
    
    function FreezedMerits(_us storage us, address a) internal view returns (uint256) {
        
        return us._userState[a]._BlockM;
        
    }
    
    function InDebted(_us storage us, address a) internal view returns (uint256) {
        
        return us._userState[a]._Debt;
        
    }
    
    function Merits(_us storage us, address a) internal view returns (uint256) {
        
        return us._userState[a]._Merit;
        
    }
    
    function Pendings(_us storage us, address a) internal view returns (uint256) {
        
        return us._userState[a]._Pending;
        
    }
    
    function Credits(_us storage us, address a) internal view returns (uint256) {
        
        return us._userState[a]._Credit;
        
    }
    
    function    ReceiveCredits(_us storage us, address _receiver, uint256 _payment) internal returns (bool) {
        
        if (us._userState[_receiver]._Debt > 0) {
            if (us._userState[_receiver]._Debt <= _payment) { 
            us._userState[_receiver]._Credit = _payment.sub(us._userState[_receiver]._Debt);
            us._userState[_receiver]._Debt = 0 ; }   else { 
            us._userState[_receiver]._Debt = us._userState[_receiver]._Debt.sub(_payment);    }
        }   else {
                us._userState[_receiver]._Credit = us._userState[_receiver]._Credit.add(_payment);
            }
        
        return true;
        
    }
    
    function    SendCredits(_us storage us, CS.ContractState storage cs, address _sender, address _receiver, uint256 _payment) 
    internal returns (bool) {
        
        require (us._userState[_receiver]._member && us._userState[_sender]._member);
        if (us._userState[_sender]._Credit < _payment) {
            
            require (us._userState[_sender]._BlockM.mul(cs._X[0]) > _payment.mul(100).div(cs._X[1])); 
            ReceiveCredits(us, _receiver, _payment);
            uint256 Delta = _payment.sub(us._userState[_sender]._Credit) ;
            us._userState[_sender]._Debt = Delta;
            us._userState[_sender]._Credit = 0;
            
        }   else    { us._userState[_sender]._Credit = us._userState[_sender]._Credit.sub(_payment);
                        ReceiveCredits(us, _receiver, _payment);    }
        
    }
    
    function    ReceiveMerits(_us storage us, address _receiver, uint256 _payment) internal returns (bool) {
        
        
    }
    
    function    ReceivePendings(_us storage us, address _receiver, uint256 _payment) internal returns (bool) {
        
        
    }
    
    /*
    function SetAlly(_us storage us, addres a) public returns(bool) {
        require (_userState[msg.sender]._member);
        us._userState[msg.sender]._AlliedChains[1] = us._userState[msg.sender]._AlliedChains[0]; 
        us._userState[msg.sender]._AlliedChains[0] = a;
    }
    */

    
    
    
}
