// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {
    uint[] public arr;
    function mergeSortedArray(uint[] memory arr1, uint[] memory arr2) public  returns (uint[] memory){
        uint i=0;
        uint j=0;
        for (; i < arr1.length && j < arr2.length;){
            if (arr1[i] > arr2[j]){
                arr.push(arr2[j]);
                j++;
                continue ;
            }
            if (arr1[i] < arr2[j]){
                arr.push(arr1[i]);
                i++;               
            }
        }
        for (;i < arr1.length;){
            arr.push(arr1[i]);
            i++;   
        }
        for (;j < arr2.length;){
            arr.push(arr2[j]);
            j++;
        }

        return arr;
    }
}