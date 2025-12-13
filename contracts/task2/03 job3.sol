// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BeggingContract is Ownable {
    mapping (address => uint256) public contributions;
    address[] contributionsArray;
    // 贡献金额
    uint256 public totalFunded;
    // 实际余额
    uint256 public balance;
    uint256 public deadline;

    event Donate(
        address indexed  addr,
        uint256 indexed  amount,
        uint256 operationTime
    );

    event Withdraw(
        address indexed  addr,
        uint256 indexed  amount,
        uint256 operationTime
    );

    modifier NoExpire(){
        require(deadline>block.timestamp, "Out of time");
        _;
    }
    // 单位为天
    constructor(uint256 _duration) Ownable(msg.sender) { 
        deadline = block.timestamp + (_duration * 1 days);
     }

    function donate() NoExpire() public payable returns (bool){
        require(msg.value > 0, "Must send ETH");

        uint amount = msg.value;
        contributions[msg.sender] = amount;
        contributionsArray.push(msg.sender);

        totalFunded += amount;
        balance += amount;

        emit Donate(msg.sender, amount, block.timestamp);
        return true;
    }

    function withdraw(uint256 _amount) public onlyOwner payable returns (bool)  {
        require(balance >= _amount, "Insufficient balance");

        balance -= _amount;
        payable(msg.sender).transfer(_amount);

        emit Withdraw(msg.sender, _amount, block.timestamp);
        return true;
    }

    function getDonation(address _addr) public view onlyOwner returns (uint256){
        return contributions[_addr];
    }

    // top3捐赠金额地址
    function getTop3Donate() public view returns (address top1, address top2, address top3){
        require(contributionsArray.length > 0, "no donator");

        // 初始化前三的地址和对应的贡献值
        uint256 top1Value = 0;
        uint256 top2Value = 0;
        uint256 top3Value = 0;

        for (uint256 i = 0; i < contributionsArray.length;){
            address currentAddr = contributionsArray[i];
            uint256 currentValue = contributions[currentAddr];

            if (currentValue >= top1Value){
                top3 = top2;
                top3Value = top2Value;
                
                top2 = top1;
                top2Value = top1Value;
                
                top1 = currentAddr;
                top1Value = currentValue;
            } else if (currentValue >= top2Value){
                top3 = top2;
                top3Value = top2Value;
                
                top2 = currentAddr;
                top2Value = currentValue;
            } else if (currentValue > top3Value){
                top3 = currentAddr;
                top3Value = currentValue;
            }

            unchecked { i++; }
        }


        return (top1, top2, top3);
    }

}