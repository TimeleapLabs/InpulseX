# Solidity API

## Migrate

### constructor

```solidity
constructor() public
```

### setIsAdmin

```solidity
function setIsAdmin(address addr, bool state) external
```

_Set `addr` admin state to `state`._

### getIsAdmin

```solidity
function getIsAdmin(address addr) public view returns (bool)
```

_Check if `addr` is is an admin._

### onlyAdmins

```solidity
modifier onlyAdmins()
```

_Throws if called by any account other than the admins._

### setToken

```solidity
function setToken(address token) external
```

_Sets the airdrop token address._

### setSender

```solidity
function setSender(address sender) external
```

_Sets the airdrop token holder address. All tokens
will be sent from this address._

### airdrop

```solidity
function airdrop(address recipient, uint256 amount) public
```

_Airdrop `amount` to `recipient`. Can be called by
admins only._

### bulkAirdrop

```solidity
function bulkAirdrop(address[] recipients, uint256[] amounts) external
```

_Airdrop `amounts` to `recipients`. Can be called by
admins only._

## Dummy

### constructor

```solidity
constructor() public
```

### balanceOf

```solidity
function balanceOf(address addr) external view returns (uint256)
```

### transferFrom

```solidity
function transferFrom(address from, address to, uint256 amount) external returns (bool)
```

## IERC20

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```

_Returns the amount of tokens in existence._

### decimals

```solidity
function decimals() external view returns (uint8)
```

_Returns the token decimals._

### symbol

```solidity
function symbol() external view returns (string)
```

_Returns the token symbol._

### name

```solidity
function name() external view returns (string)
```

_Returns the token name._

### getOwner

```solidity
function getOwner() external view returns (address)
```

_Returns the erc token owner._

### balanceOf

```solidity
function balanceOf(address account) external view returns (uint256)
```

_Returns the amount of tokens owned by `account`._

### transfer

```solidity
function transfer(address recipient, uint256 amount) external returns (bool)
```

_Moves `amount` tokens from the caller's account to `recipient`.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### allowance

```solidity
function allowance(address _owner, address spender) external view returns (uint256)
```

_Returns the remaining number of tokens that `spender` will be
allowed to spend on behalf of `owner` through {transferFrom}. This is
zero by default.

This value changes when {approve} or {transferFrom} are called._

### approve

```solidity
function approve(address spender, uint256 amount) external returns (bool)
```

_Sets `amount` as the allowance of `spender` over the caller's tokens.

Returns a boolean value indicating whether the operation succeeded.

IMPORTANT: Beware that changing an allowance with this method brings the risk
that someone may use both the old and the new allowance by unfortunate
transaction ordering. One possible solution to mitigate this race
condition is to first reduce the spender's allowance to 0 and set the
desired value afterwards:
https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

Emits an {Approval} event._

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool)
```

_Moves `amount` tokens from `sender` to `recipient` using the
allowance mechanism. `amount` is then deducted from the caller's
allowance.

Returns a boolean value indicating whether the operation succeeded.

Emits a {Transfer} event._

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

_Emitted when `value` tokens are moved from one account (`from`) to
another (`to`).

Note that `value` may be zero._

### Approval

```solidity
event Approval(address owner, address spender, uint256 value)
```

_Emitted when the allowance of a `spender` for an `owner` is set by
a call to {approve}. `value` is the new allowance._

## Context

### constructor

```solidity
constructor() public
```

### _msgSender

```solidity
function _msgSender() internal view returns (address)
```

## Ownable

_Contract module which provides a basic access control mechanism, where
there is an account (an owner) that can be granted exclusive access to
specific functions.

By default, the owner account will be the one that deploys the contract. This
can later be changed with {transferOwnership}.

This module is used through inheritance. It will make available the modifier
`onlyOwner`, which can be applied to your functions to restrict their use to
the owner._

### OwnershipTransferred

```solidity
event OwnershipTransferred(address previousOwner, address newOwner)
```

### constructor

```solidity
constructor() public
```

_Initializes the contract setting the deployer as the initial owner._

### owner

```solidity
function owner() public view returns (address)
```

_Returns the address of the current owner._

### onlyOwner

```solidity
modifier onlyOwner()
```

_Throws if called by any account other than the owner._

### renounceOwnership

```solidity
function renounceOwnership() external
```

_Leaves the contract without owner. It will not be possible to call
`onlyOwner` functions anymore. Can only be called by the current owner.

NOTE: Renouncing ownership will leave the contract without an owner,
thereby removing any functionality that is only available to the owner._

### transferOwnership

```solidity
function transferOwnership(address newOwner) external
```

_Transfers ownership of the contract to a new account (`newOwner`).
Can only be called by the current owner._

### _transferOwnership

```solidity
function _transferOwnership(address newOwner) internal
```

_Transfers ownership of the contract to a new account (`newOwner`)._

