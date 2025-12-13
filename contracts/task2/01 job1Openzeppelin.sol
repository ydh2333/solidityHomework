// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC20 is ERC20, Ownable {

    // ===========构造函数===========
    /**
    * @dev 初始化代币名称、符号、初始发行量、税率等
    * @param _name 代币名称（如 "MyToken"）
    * @param _symbol 代币符号（如 "MTK"）
    * @param _initialSupply 初始发行量（单位：wei，如需1000枚则传 1000）
    */
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(msg.sender, _initialSupply * 10 ** 18);
    }

    /**
     * @dev 铸造新代币（仅所有者）
     * @param _to 接收地址
     * @param _amount 铸造数量
     */
    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    /**
     * @dev 销毁代币（仅所有者）
     * @param _account 销毁地址
     * @param _amount 销毁数量
     */
    function burn(address _account, uint256 _amount) external onlyOwner {
        _burn(_account, _amount);
    }

}