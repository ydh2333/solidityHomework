// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseStr {
    function reverse(string memory _str) public pure returns (string memory){
        bytes memory str =  bytes(_str);
        bytes1 a;
        for(uint i; i < str.length / 2;){
            a = str[i];
            str[i] = str[str.length-1-i];
            str[str.length-1-i] = a;
            unchecked{
                i++;
            }
        }
        return string(str);
    }



}