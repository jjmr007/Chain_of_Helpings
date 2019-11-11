pragma solidity ^0.5.12;

import { SafeMath } from "./LSafeMath.sol";

import { UserStt as _US } from "./LUserState.sol";

import { ContractStt as _CS } from "./LContractState.sol";

library gObjects {

    using _US for _US._us;
    using _CS for _CS.ContractState;
    using SafeMath for uint256;

    struct Ballot {
        
        uint8   _kind;
        mapping (address => bytes32) _commits;
        address[]   _Voters;
        
    }
    
    struct  Votes { 
        
        mapping (bytes32 => Ballot) _Proposals;
        mapping (bytes32 => uint256[2]) _tally;
        bytes32[]   _propHases;
        Tally _Tll;

    }
    
    struct Tally {
        
        uint256[3]  _Y;
        uint256 _n;
        
    }
    
    
    function CommitMeritValue(_US._us storage _User, _CS.ContractState storage _cs, Votes storage _v, bytes32 x) 
    internal returns (bool) {
        
        bytes32 _H = bytes32(0);
        uint256 A = ((now.sub(_cs._Reference)).div(86400)).mod(21);
        require (_User._userState[msg.sender]._Credit >= 100*10**(18)); // to change "Credit._decimals"
        require (A >= 15 && A <= 17);
            _US.SendCredits(_User, _cs, msg.sender, _cs._Principal, 100*10**(18));
        _v._Proposals[_H]._commits[msg.sender] = x;
        _v._Proposals[_H]._Voters.push(msg.sender);
       return true;
    
    }
    
    function PunishMeritValue(_US._us storage us, _CS.ContractState storage _cs,  Votes storage _v, 
    uint256[3] memory _x, string memory _s, address _a) 
    internal returns (bool) {

        bytes32 _H = bytes32(0);
        uint256 A = ((now.sub(_cs._Reference)).div(86400)).mod(21);
        require (A >= 15 && A <= 17);
        require (keccak256(abi.encodePacked(_x[0] + _x[1] + _x[2] + uint256(sha256(bytes(_s)))))
        ==  _v._Proposals[_H]._commits[_a] && _x[1] >=10 && _x[1] <= 100 && _x[2] >= 5 && _x[2] <= 30);
        if (_v._Proposals[_H]._Voters.length >= 1)
        {   
        RemoveVoter(_v, _H, _a);
        _v._Proposals[_H]._commits[_a] = bytes32(0);
        _US.SendCredits(us, _cs, _cs._Principal, msg.sender, 100*10**(18));
        }   
    }
    
    
    function SetMeritValue(_US._us storage us, _CS.ContractState storage _cs, Votes storage _v,
    uint256[3] memory _x, string memory _s) 
    internal returns (bool) {

        bytes32 _H = bytes32(0);
        uint256 A = ((now.sub(_cs._Reference)).div(86400)).mod(21);
        if (A >= 18 && A <=20) { 
        require (keccak256(abi.encodePacked(_x[0] + _x[1] + _x[2] + uint256(sha256(bytes(_s)))))
        ==  _v._Proposals[_H]._commits[msg.sender] && _x[1] >=10 && _x[1] <= 100 && _x[2] >= 5 && _x[2] <= 30); 
            if (_v._Proposals[_H]._Voters.length >= 1)
    {    
        RemoveVoter(_v, _H, msg.sender);
        _v._Proposals[_H]._commits[msg.sender] = bytes32(0);
        _v._Tll._n++;
        _v._Tll._Y[0] = ((_v._Tll._Y[0].mul(_v._Tll._n.sub(1))).add(_x[0])).div(_v._Tll._n);
        _v._Tll._Y[1] = ((_v._Tll._Y[1].mul(_v._Tll._n.sub(1))).add(_x[1])).div(_v._Tll._n);
        _v._Tll._Y[2] = ((_v._Tll._Y[2].mul(_v._Tll._n.sub(1))).add(_x[2])).div(_v._Tll._n);
        _US.SendCredits(us, _cs, _cs._Principal, msg.sender, 100*10**(18));
        if (_v._Proposals[_H]._Voters.length == 0) { 
            if (_v._Tll._n > _cs._TotalMembers.mul(100).div(_cs._X[2]))  { _cs._X = _v._Tll._Y; } _v._Tll._n = 0; }
    }
        } else if (A >= 0 && A <= 14 && _v._Proposals[_H]._Voters.length != 0) {

        if (keccak256(abi.encodePacked(_x[0] + _x[1] + _x[2] + uint256(sha256(bytes(_s)))))
        ==  _v._Proposals[_H]._commits[msg.sender] && _x[1] >=10 && _x[1] <= 100 && _x[2] >= 5 && _x[2] <= 30) {        
        _US.SendCredits(us, _cs, _cs._Principal, msg.sender, 100*10**(18));
        }
        if (_v._Tll._n > _cs._TotalMembers.mul(100).div(_cs._X[2]))  { _cs._X = _v._Tll._Y; } 
        _v._Tll._n = 0;
        
    for (uint i=0; i< _v._Proposals[_H]._Voters.length ; i++){
        _v._Proposals[_H]._commits[_v._Proposals[_H]._Voters[i]] = bytes32(0);
    }
    _v._Proposals[_H]._Voters.length = 0;
        }
        return true;
    }
    
    function RemoveVoter(Votes storage _v, bytes32 _H, address _Remove) 
    private returns (bool) {

        for (uint256 i = 0; i < _v._Proposals[_H]._Voters.length; i++) {
            if (_v._Proposals[_H]._Voters[i] == _Remove && i < _v._Proposals[_H]._Voters.length-1) {
                    _v._Proposals[_H]._commits[_v._Proposals[_H]._Voters[i]] = bytes32(0);
                for (uint256 j = i; j < _v._Proposals[_H]._Voters.length-1; j++) {
                    _v._Proposals[_H]._Voters[j] = _v._Proposals[_H]._Voters[j+1];
                } 
                delete _v._Proposals[_H]._Voters[_v._Proposals[_H]._Voters.length-1];
                _v._Proposals[_H]._Voters.length--;

            } else if (_v._Proposals[_H]._Voters[i] == _Remove && i == _v._Proposals[_H]._Voters.length-1) {
                _v._Proposals[_H]._commits[_v._Proposals[_H]._Voters[i]] = bytes32(0);
                delete _v._Proposals[_H]._Voters[_v._Proposals[_H]._Voters.length-1];
                _v._Proposals[_H]._Voters.length--;

                } 
        } 
    }    

    
}
