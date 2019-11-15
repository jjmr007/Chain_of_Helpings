pragma solidity ^0.5.12;

import { UserStt as _US } from "./LUserState.sol";

import { ContractStt as _CS } from "./LContractState.sol";

contract Alien  {
    
        function GetMembership(address _chain, address _a) public view returns(bool) ;
        function GetMemberS(address _chain) public view returns (uint256);
        function GetMember(address _chain, uint256 _k) public view returns(address);
        function GetMemberBalances(address _chain, address a, uint8 j) public view returns(uint256);
        function GetaTotal(address _chain, uint8 k) public view returns(uint256);
        function MeritParam(address _chain, uint8 k) public view returns(uint256);
        function isAllied(address _chain, address a) public view returns(bool);
        function GetAllied(address _chain, uint256 _k) public view returns(address);
        function TotalAlliances(address _chain) public view returns(uint256);
        
        function SetMemberBalance(address _chain, address _a, uint8 i, uint256 _balance) public ;
        function SetaBalance(address _chain, uint8 k, uint256 _balance) public ;

}

contract Master {
    
    using _US for _US._us;
    using _CS for _CS.ContractState;
    
    event   Authorized (
        address _from,
        address _Proxy
        );

    event   Upgrade (
        /* 
        *   master does not stores upgrade addresses
        *   it tracks these changes by events
        */
        address _Proxy, // where the contract migrated to;
        address _Sender // where the contract comes from;
        );
    
    _US._us internal _User;
    _CS.ContractState internal _cs;

    constructor (address[] memory A, uint256[3] memory _MeritVal) public {

       _User._Members.push(address(1));
       _cs._X = _MeritVal;
       _cs._Sums[0] = now;

       for (uint32 i; i < A.length ; i++) {

            _User.SetMember(A[i]);

       }

    }
    
    function AuthorizeProxy(address _Proxy) public {
        
        require (_User.isMember(msg.sender) && _User._Members[0] == address(1)); // be careful, this is one shot try!

        // here the method "SetMember" won't work
       _User._userState[_Proxy]._member = true;
       _User._Members[0] = _Proxy;
       
       emit Authorized(msg.sender, _Proxy);
        
    }
    
    function UpGrade(address _Proxy) public {
        
        require(msg.sender == _User._Members[0]);
        _User._userState[_Proxy]._member = true;
        _User._userState[msg.sender]._member = false;
        _User._Members[0] = _Proxy;

        emit Upgrade(_Proxy, msg.sender);
        
    }
    
    function GetMembership(address _chain, address _a) public view returns(bool) {
        
        if (_chain == address(0)) {
        return  _User.isMember(_a); } else {
            Alien _Aln = Alien(_chain);
            _Aln.GetMembership(address(0), _a);
        }
        
    }
    
    function GetMemberS(address _chain) public view returns (uint256) {
        
        if (_chain == address(0)) {
        return  _User.TotalMembers(); } else {
            Alien _Aln = Alien(_chain);
            return _Aln.GetMemberS(address(0)); }
        
    }
    
    function GetMember(address _chain, uint256 _k) public view returns(address) {
    
        if (_chain == address(0)) {
        return  _User.GetMember(_k); } else {
            Alien _Aln = Alien(_chain);
        return _Aln.GetMember(address(0), _k); }    
        
    }
    
    function GetMemberBalances(address _chain, address a, uint8 j) public view returns(uint256) {
        
        if (_chain == address(0)) {
        return  _User.GetBalances(a, j); } else {
            Alien _Aln = Alien(_chain);
        return _Aln.GetMemberBalances(address(0), a, j); }
        
    }
    
    function SetMembership(address _a) public  {
        
        require(msg.sender == _User._Members[0]);
        _User.SetMember(_a);
        
    }
    
    function SetMemberBalance(address _chain, address _a, uint8 i, uint256 _balance) public {
        
        if (_chain == address(0)) {
        require(msg.sender == _User._Members[0] || _cs._Bridges[msg.sender]);
            
            if(msg.sender == _User._Members[0]) {
                _User.SetBalance(_a, i, _balance);
            } else {
                Alien _Aln = Alien(msg.sender);
                require(_Aln.isAllied(address(0), address(this)), "Chain not allied yet to do balance changes")
                require(i == 1 || i == 4, "Balance change not allowed");
                _User.SetBalance(_a, i, _balance);
            }
            
        }   else {
             Alien _Aln = Alien(_chain);
             require (msg.sender == _User._Members[0] && isAllied(address(0), _chain) && _Aln.isAllied(address(0), address(this)));
             require (i == 1 || i == 4, "unauthorized change of balance");
             _Aln.SetMemberBalance(address(0), _a, i, _balance);
        }
    
    }
        
    function GetaTotal(address _chain, uint8 k) public view returns(uint256) {
        
        if (_chain == address(0)) {
        return _cs.GetTotals(k); } else {
            Alien _Aln = Alien(_chain);
        return _Aln.GetaTotal(address(0), k);
        }
        
    }
    
    function MeritParam(address _chain, uint8 k) public view returns(uint256) {
        
        if (_chain == address(0)) {
        return _cs.GetMeritValues( k); } else {
            Alien _Aln = Alien(_chain);
        return _Aln.MeritParam(address(0), k);
        }
        
    }
    
    function isAllied(address _chain, address a) public view returns(bool) {
        
        if (_chain == address(0)) {
        return _cs._Bridges[a]; } else {
            Alien _Aln = Alien(_chain);
        return _Aln.isAllied(address(0), a);
        }
        
    }
    
    function GetAllied(address _chain, uint256 _k) public view returns(address) {
        
        if (_chain == address(0)) {
        return _cs.BridgebyID(_k); } else {
            Alien _Aln = Alien(_chain);
        return _Aln.GetAllied(address(0), _k);
        }
        
    }
    
    function TotalAlliances(address _chain) public view returns(uint256) {
        
        if (_chain == address(0)) {
        return _cs._BRdgs.length; } else {
            Alien _Aln = Alien(_chain);
        return _Aln.TotalAlliances(address(0));
        }
        
    }
    
    function SetaBalance(address _chain, uint8 k, uint256 _balance) public {
        
        if (_chain == address(0)) {
        require(msg.sender == _User._Members[0] || _cs._Bridges[msg.sender]);

        if(msg.sender == _User._Members[0]) {
            _cs.SetNetValue(k, _balance);
            } else {
                Alien _Aln = Alien(msg.sender);
                require(_Aln.isAllied(address(0), address(this)), "Chain not allied yet to do balance changes")
                require(i == 2 || i == 5, "Balance change not allowed");
                _cs.SetNetValue(k, _balance);
            }        

         } else {
             Alien _Aln = Alien(_chain);
        require (msg.sender == _User._Members[0] && isAllied(address(0), _chain) && _Aln.isAllied(address(0), address(this)));
        require (k == 2 || k == 5, "unauthorized change of balance");
        _Aln.SetaBalance(address(0), k, _balance);
        }        
        
    }
       
    function SetMerit(uint256[3] memory x) public {
        
        require(msg.sender == _User._Members[0]);
        _cs.SetMeritValues(x);        
        
    }
    
    function SetAlliance(address a) public {
        
        require(msg.sender == _User._Members[0]);
        _cs.SetBridge(a);        
        
    }
    
}
