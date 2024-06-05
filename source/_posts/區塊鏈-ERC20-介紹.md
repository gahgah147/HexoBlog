---
title: 區塊鏈 - ERC20 介紹
date: 2024-05-21 10:34:57
tags:
    - ETH
    - Solidity
    - ERC20
    - Web3
---
# 區塊鏈 - ERC20 介紹

# ERC 20 是什麼?
ERC20 是以太坊區塊鏈上代幣標準的一種協議，為智能合約提供了統一的介面，使得各種代幣能夠在不同的去中心化應用（DApps）中互操作。這個標準包含了一組必要的方法，使得代幣的創建和交易變得一致且容易。

"ERC" 的全名是 "Ethereum Request for Comment"，中文翻譯是 "以太坊徵集修正意見書"。ERC 是以太坊社群用來提出和討論改進提案的標準。這些提案通常涉及智能合約標準、應用程序介面（API）或協議的改進。

其中，ERC20 是最著名的一個標準，定義了在以太坊區塊鏈上實現可互操作的代幣所需的基本介面。這個標準使得各種代幣能夠在不同的去中心化應用中方便地進行交易和互操作。

此外，還有其他一些常見的 ERC 標準，例如：

ERC721：非同質化代幣（NFT）的標準，適用於獨特的資產如收藏品、遊戲內物品等。
ERC1155：多代幣標準，允許單一合約中管理多種代幣，包括同質化代幣和非同質化代幣。

## ERC20 標準的關鍵方法

1. **totalSupply**:  在不需要支付 ETH 礦工費的情況下查詢代幣的總供應量。
   ```solidity
   function totalSupply() external view returns (uint256);
   ```

2. **balanceOf**: 查詢指定地址擁有的代幣數量。
   ```solidity
   function balanceOf(address account) external view returns (uint256);
   ```

3. **transfer**: 從調用者的賬戶轉移指定數量的代幣到目標地址。
   ```solidity
   function transfer(address recipient, uint256 amount) external returns (bool);
   ```

4. **allowance**: 查詢代幣所有者允許花費者花費的剩餘代幣數量。
   ```solidity
   function allowance(address owner, address spender) external view returns (uint256);
   ```

5. **approve**: 允許指定的花費者從調用者的賬戶中提取代幣。
   ```solidity
   function approve(address spender, uint256 amount) external returns (bool);
   ```

6. **transferFrom**: 從一個賬戶轉移指定數量的代幣到另一個賬戶，這個操作由有花費權限的賬戶調用。
   ```solidity
   function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
   ```
## ERC20 標準的事件


1. **Transfer**: 在代幣轉移時觸發。
   ```solidity
   event Transfer(address indexed from, address indexed to, uint256 value);
   ```

2. **Approval**: 在代幣所有者批准花費者可以花費的代幣數量變更時觸發。
   ```solidity
   event Approval(address indexed owner, address indexed spender, uint256 value);
   ```


# 實作練習

## 開發 ERC20_Metadata.sol

這個練習是可以讓我們部屬自己的ERC20 代幣，可以自己取代幣名字、跟代幣簡稱

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20Metadata {
    function name() external view returns (string memory); // 代幣名稱
    function symbol() external view returns (string memory); // 代幣符號
    function decimals() external view returns (uint8); // 代幣小數點位置
}

contract ERC20 is IERC20Metadata {
    string _name;
    string _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // 查詢代幣名稱
    function name() public view returns (string memory) {
        return _name;
    }

    // 查詢代幣符號
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    // 代幣小數點位置
    function decimals() public pure returns (uint8) {
        return 18;
    }
}
```
![image](https://hackmd.io/_uploads/Sy141FFQ0.png)

### 部屬

![image](https://hackmd.io/_uploads/r1yOkFtmC.png)

在部屬的時候填入name、symbol可以進行部屬

![image](https://hackmd.io/_uploads/rkU3ytYmA.png)

成功部屬結果

## 鑄造(Mint)和燒毀(Burn)新代幣

![image](https://hackmd.io/_uploads/SyhpcaKXA.png)



這個實作例子我們可以鑄造新代幣跟燒毀新代幣，並且有以下功能

* 只有部屬合約的人才可以鑄造/燃燒代幣
* 轉帳的合約不能是address(0)
* 鑄造/燃燒代幣時，總發行量也會增加/減少。
* 指定某帳戶增加/銷毀代幣


```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function mint(address account, uint256 value) external;
    function burn(address account, uint256 value) external;
}

contract ERC20 is IERC20 {
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    address private _owner;

    constructor() {
        _totalSupply = 10000;  // 總發行量: 10000 個token
        _balances[msg.sender] = 10000;  // 將以太幣持有者的賬戶新增10000 顆token
        _owner = msg.sender;
    }

    modifier checkOwner() {
        require(_owner == msg.sender, unicode"不是合約擁有者");
        _;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) external override returns (bool) {
        require(_balances[msg.sender] >= value, unicode"餘額不足");
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) external override returns (bool) {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external override returns (bool) {
        require(_balances[from] >= value, unicode"餘額不足");
        require(_allowances[from][msg.sender] >= value, unicode"許可權不足");
        _balances[from] -= value;
        _balances[to] += value;
        _allowances[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(address account, uint256 value) external override checkOwner {
        require(account != address(0), unicode"address不能是0x0");  // 檢查帳戶不能是0x0
        _totalSupply += value;  // 增加總發行量
        _balances[account] += value;  // 增加目標賬戶餘額
        emit Transfer(address(0), account, value);  // 無中生有(address(0)=>account): (address(0), 指定帳戶, 多少代幣)
    }

    function burn(address account, uint256 value) external override checkOwner {
        uint256 accountBalance = _balances[account];  // 確認賬戶餘額
        require(account != address(0), unicode"address不能是0x0");  // 檢查帳戶不能是0x0
        require(accountBalance >= value, unicode"餘額不足");  // 檢查餘額夠不夠燒毀
        _balances[account] = accountBalance - value;  // 指定賬戶銷毀代幣
        _totalSupply = _totalSupply - value;  // 總發行量也會跟著減少
        emit Transfer(account, address(0), value);  // 回歸虛無(account=>address(0)): (指定賬戶, address(0), 多少代幣)
    }
}
```
![image](https://hackmd.io/_uploads/rJxuSpt70.png)

![image](https://hackmd.io/_uploads/SyrKSTF7R.png)

### 部屬

測試鑄造 10000
![image](https://hackmd.io/_uploads/SkZbzpKXC.png)

測試查詢餘額會增加
![image](https://hackmd.io/_uploads/HJ6hzptQ0.png)

測試燒毀 1000
![image](https://hackmd.io/_uploads/SkcbHaYmA.png)

測試查詢餘額會減少
![image](https://hackmd.io/_uploads/r1_QBpK70.png)
