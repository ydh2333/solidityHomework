// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInt {
    mapping (bytes1=>uint) public romanList;

    function romanToInt(string memory _str) public returns (uint){
        romanList[bytes1("I")] = 1;
        romanList[bytes1("V")] = 5;
        romanList[bytes1("X")] = 10;
        romanList[bytes1("L")] = 50;
        romanList[bytes1("C")] = 100;
        romanList[bytes1("D")] = 500;
        romanList[bytes1("M")] = 1000;
        uint num;
        bytes memory strBy = bytes(_str);
        for (uint i = 0; i < strBy.length; i++){
            if (i < strBy.length-1 && romanList[strBy[i]]<romanList[strBy[i+1]]){
                num = num + romanList[strBy[i+1]] - romanList[strBy[i]];
                i++;
            } else { 
                num += romanList[strBy[i]];
            }
        }
        return num;
    }

}