// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public voteExist;
    mapping(address => uint) public voteCount;
    address[] public roles;


    function vote(address _address) public {
        if (!voteExist[_address]){
            voteExist[_address] = true;
            roles.push(_address);
        }
        voteCount[_address] += 1;
    }

    function getVotes(address _address) public view returns (uint){
        return voteCount[_address];
    }

    function resetVotes() public {
        for (uint i = 0; i < roles.length;){
            delete voteCount[roles[i]];
            unchecked{
                i++;
            }
        }
    }
}