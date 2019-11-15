pragma solidity ^0.5.12;

library UserStt {
    
    /*
    *   it gives:
    *   if an address is or not a member;
    *   how many members there are;
    *   a member address according an array position;
    *   any balance of a member;
    *
    *   it allows:
    *   add a member;
    *   set any balance for a member address;
    */
    
    struct UserState {
        
        bool    _member;
        uint256[5]  _Balance;
        /*
        uint256 _BlockM;    // _Balance[0];
        uint256 _Debt;      // _Balance[1];
        uint256 _Merit;     // _Balance[2];
        uint256 _Pending;   // _Balance[3];
        uint256 _Credit;    // _Balance[4];
        */
        
    }

    struct  _us {
        
        mapping (address => UserState)  _userState;
        address[]   _Members;
        
    }
    
    function isMember(_us storage us, address a) internal view returns(bool) {
        
        return us._userState[a]._member;
        
    }
    
    function TotalMembers(_us storage us) internal view returns (uint256) {
        
        return us._Members.length;
        
    }

    function GetMember(_us storage us, uint256 k) internal view returns (address) {
        
        require(us._Members.length > k, "that member number does not exist");
        return us._Members[k];
        
    }
    
    function GetBalances(_us storage us, address a, uint8 b) internal view returns (uint256) {
        
        require (b < 5, "Not a valid register");
        require(us._userState[a]._member, "Not a valid member");
        return us._userState[a]._Balance[b];
        
    }
    
    function SetMember(_us storage us, address a) internal {
        
        require(!us._userState[a]._member);
        us._Members.push(a);
        us._userState[a]._member = true;
        
    }
    
    function SetBalance(_us storage us, address a, uint8 b, uint256 _balance) internal {
        
        require (b < 5, "Not a valid register");
        require(us._userState[a]._member, "Not a valid member");
        us._userState[a]._Balance[b] = _balance;
        
    }

}
