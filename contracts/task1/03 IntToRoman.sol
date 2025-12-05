// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntToRoman {
    mapping (uint => string) public valueLists;
    uint[] values = [1,4,5,9,10,40,50,90,100,400,500,900,1000];
    uint[] public  nums;
    function intToRoman(uint _num) public returns (string memory){
        valueLists[1] = "I";
        valueLists[4] = "IV";
        valueLists[5] = "V";
        valueLists[9] = "IX";
        valueLists[10] = "X";
        valueLists[40] = "XL";
        valueLists[50] = "L";
        valueLists[90] = "XC";
        valueLists[100] = "C";
        valueLists[400] = "CD";
        valueLists[500] = "D";
        valueLists[900] = "CM";
        valueLists[1000] = "M";

        string memory str1;
        string memory str2;
        // 拆解各个分位的数
        for(uint i = 10; _num != 0; i*=10){
            if(_num%i == 0){
                continue;
            }
            nums.push(_num % i);
            _num -= (_num % i);
        }

        // 遍历拆解的分位数据
        for(uint i = 0; i < nums.length; i++){
            // 将各个分位的数转换为罗马数
            for(uint j = 0; j < values.length; ){
                if (nums[i] == values[j]){
                    str1 = string.concat(str1,"",valueLists[values[j]]);
                    break;
                }

                if (nums[i] < values[j]){
                    nums[i] -= values[j-1];
                    str1 = string.concat(str1,"",valueLists[values[j-1]]);
                    j = 0;
                    continue ;
                }

                if (j == values.length-1){
                    nums[i] -= values[j];
                    str1 = string.concat(str1,"",valueLists[values[j]]);
                    continue ;
                }
                if (nums[i] > values[j] && j < (values.length-1)){
                    j++;
                }

            }
            str2 = string.concat(str1, str2);
            str1 = "";
        }
        delete nums;
        return str2;
    }
}