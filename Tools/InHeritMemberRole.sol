pragma solidity ^0.5.12;

import { Context } from "./InHeritContext.sol";

import { Roles } from "./LRoles.sol";

contract MemberRole is Context {

    using Roles for Roles.Role;

    event MemberAdded(address indexed account);
    event MemberRemoved(address indexed account);

    Roles.Role private _members;

    constructor () internal {
        _addMember(_msgSender());
    }

    modifier onlyMember() {
        require(isMember(_msgSender()), "MemberRole: caller is not a member");
        _;
    }

    function isMember(address account) public view returns (bool) {
        return _members.has(account);
    }

    function addMember(address account) public onlyMember {
        /*
        adding a member is only possible by a valid Merit Escrow
        */
        _addMember(account);
    }

    function renounceMember() public {
        _removeMember(_msgSender());
    }

    function _addMember(address account) internal {
        _members.add(account);
        emit MemberAdded(account);
    }

    function _removeMember(address account) internal {
        /*
        an approved proposal must authorize this 
        */
        _members.remove(account);
        emit MemberRemoved(account);
    }
    
}
