// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    function binarySearch(uint[] memory nums, uint target) public pure  returns (uint){
        uint left=0;
        uint right=nums.length-1;
        uint mid;
        for (;left <= right;){
            mid=(left+right)/2;
            if (nums[mid] == target){
                return mid;
            }else if (nums[mid] > target){
                // 目标在左区间
                right = mid - 1;
            }else {
                // 目标在右区间
                left = mid + 1;
            }
        }
        return 0;
    }

}