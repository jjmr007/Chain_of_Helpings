pragma solidity ^0.5.12;

import { Roles } from "./LRoles.sol";

import { MemberRole } from "./InHeritMemberRole.sol";

import { Context } from "./InHeritContext.sol";

import { SafeMath } from "./LSafeMath.sol";

import { UserStt as _US } from "./LUserState.sol";

import { ContractStt as _CS } from "./LContractState.sol";

contract Helpings {
    using SafeMath for uint256;
    using _US for _US._us;
    using _CS for _CS.ContractState;

    _US._us internal _User;
    _CS.ContractState internal _cs;
    
    constructor(address[] memory A, uint256[3] memory _MeritVal) public {
       _cs._Principal = address(this); // While used internally without external calls, 'this' will work properly
       _User._userState[_cs._Principal]._member = true;
       _cs._Members = A;
       _cs._TotalMembers = A.length;
       _cs._X = _MeritVal;
       _cs._Reference = now;
       for (uint32 i; i < A.length ; i++) {
           
           _User._userState[A[i]]._member = true;
          //  _userState[Principal]._Merit++;
          // _userState[A[i]]._Pending++;
           
       }
    }
    
}

contract erc_20 is Context, Helpings {
    using SafeMath for uint256;
    
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }
    
    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }  
    
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    function _transfer(address sender, address recipient, uint256 amount) internal ; // {
 /*
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }
*/   
    event Transfer(address indexed from, address indexed to, uint256 value);    
    
}

contract Merit is erc_20 {
    

}

contract Pending is erc_20 {


    
}

contract Credit is erc_20 {


    
}

contract EscrowHelp {

    
    
}

contract EscrowMerch {
    

    
}
