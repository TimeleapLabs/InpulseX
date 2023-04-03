# Solidity API

## TestSpender

Test smart contracts

### number

```solidity
uint256 number
```

### str

```solidity
string str
```

### boolean

```solidity
bool boolean
```

### amount

```solidity
uint256 amount
```

### from

```solidity
address from
```

### onApprovalReceived

```solidity
function onApprovalReceived(address _from, uint256 _amount, bytes data) external returns (bytes4)
```

## TestReceiver

### number

```solidity
uint256 number
```

### str

```solidity
string str
```

### boolean

```solidity
bool boolean
```

### amount

```solidity
uint256 amount
```

### from

```solidity
address from
```

### onTransferReceived

```solidity
function onTransferReceived(address, address _from, uint256 _amount, bytes data) external returns (bytes4)
```

## InpulseX

### constructor

```solidity
constructor() public
```

### getOwner

```solidity
function getOwner() external view returns (address)
```

_Returns the contract owner._

### decimals

```solidity
function decimals() external pure returns (uint8)
```

_Returns the token decimals._

### symbol

```solidity
function symbol() external pure returns (string)
```

_Returns the token symbol._

### name

```solidity
function name() external pure returns (string)
```

_Returns the token name._

### totalSupply

```solidity
function totalSupply() external pure returns (uint256)
```

_See {ERC20-totalSupply}._

### balanceOf

```solidity
function balanceOf(address account) public view returns (uint256)
```

_See {ERC20-balanceOf}._

### transfer

```solidity
function transfer(address recipient, uint256 amount) public returns (bool)
```

_See {ERC20-transfer}.

Requirements:

- `recipient` cannot be the zero address.
- the caller must have a balance of at least `amount`._

### allowance

```solidity
function allowance(address addr, address spender) external view returns (uint256)
```

_See {ERC20-allowance}._

### approve

```solidity
function approve(address spender, uint256 amount) public returns (bool)
```

_See {ERC20-approve}.

Requirements:

- `spender` cannot be the zero address._

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) public returns (bool)
```

_See {ERC20-transferFrom}.

Emits an {Approval} event indicating the updated allowance. This is not
required by the EIP. See the note at the beginning of {ERC20};

Requirements:
- `sender` and `recipient` cannot be the zero address.
- `sender` must have a balance of at least `amount`.
- the caller must have allowance for `sender`'s tokens of at least
`amount`._

### increaseAllowance

```solidity
function increaseAllowance(address spender, uint256 addedValue) external returns (bool)
```

_Atomically increases the allowance granted to `spender` by the caller.

This is an alternative to {approve} that can be used as a mitigation for
problems described in {ERC20-approve}.

Emits an {Approval} event indicating the updated allowance.

Requirements:

- `spender` cannot be the zero address._

### decreaseAllowance

```solidity
function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool)
```

_Atomically decreases the allowance granted to `spender` by the caller.

This is an alternative to {approve} that can be used as a mitigation for
problems described in {ERC20-approve}.

Emits an {Approval} event indicating the updated allowance.

Requirements:

- `spender` cannot be the zero address.
- `spender` must have allowance for the caller of at least
`subtractedValue`._

### Reflect

```solidity
event Reflect(uint256 amount)
```

### _transfer

```solidity
function _transfer(address sender, address recipient, uint256 amount) internal
```

_Moves tokens `amount` from `sender` to `recipient`.

This is internal function is equivalent to {transfer}, and can be used to
e.g. implement automatic token fees, slashing mechanisms, etc.

Emits a {Transfer} event.
Emits a {Reflect} event.

Requirements:

- `sender` cannot be the zero address.
- `recipient` cannot be the zero address.
- `sender` must have a balance of at least `amount`._

### _approve

```solidity
function _approve(address addr, address spender, uint256 amount) internal
```

_Sets `amount` as the allowance of `spender` over the `addr`s tokens.

This is internal function is equivalent to `approve`, and can be used to
e.g. set automatic allowances for certain subsystems, etc.

Emits an {Approval} event.

Requirements:

- `addr` cannot be the zero address.
- `spender` cannot be the zero address._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external pure returns (bool)
```

_See {IERC165-supportsInterface}._

### transferAndCall

```solidity
function transferAndCall(address recipient, uint256 amount) external returns (bool)
```

_Transfer tokens to a specified address and then execute a callback on recipient._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The address to transfer to. |
| amount | uint256 | The amount to be transferred. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### transferAndCall

```solidity
function transferAndCall(address recipient, uint256 amount, bytes data) public returns (bool)
```

_Transfer tokens to a specified address and then execute a callback on recipient._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The address to transfer to |
| amount | uint256 | The amount to be transferred |
| data | bytes | Additional data with no specified format |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### transferFromAndCall

```solidity
function transferFromAndCall(address sender, address recipient, uint256 amount) external returns (bool)
```

_Transfer tokens from one address to another and then execute a callback on recipient._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| sender | address | The address which you want to send tokens from |
| recipient | address | The address which you want to transfer to |
| amount | uint256 | The amount of tokens to be transferred |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### transferFromAndCall

```solidity
function transferFromAndCall(address sender, address recipient, uint256 amount, bytes data) public returns (bool)
```

_Transfer tokens from one address to another and then execute a callback on recipient._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| sender | address | The address which you want to send tokens from |
| recipient | address | The address which you want to transfer to |
| amount | uint256 | The amount of tokens to be transferred |
| data | bytes | Additional data with no specified format |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### approveAndCall

```solidity
function approveAndCall(address spender, uint256 amount) external returns (bool)
```

_Approve spender to transfer tokens and then execute a callback on recipient._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | The address allowed to transfer to |
| amount | uint256 | The amount allowed to be transferred |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### approveAndCall

```solidity
function approveAndCall(address spender, uint256 amount, bytes data) public returns (bool)
```

_Approve spender to transfer tokens and then execute a callback on recipient._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | The address allowed to transfer to. |
| amount | uint256 | The amount allowed to be transferred. |
| data | bytes | Additional data with no specified format. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | A boolean that indicates if the operation was successful. |

### _checkAndCallTransfer

```solidity
function _checkAndCallTransfer(address sender, address recipient, uint256 amount, bytes data) internal returns (bool)
```

_Internal function to invoke `onTransferReceived` on a target address
 The call is not executed if the target address is not a contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| sender | address | address Representing the previous owner of the given token value |
| recipient | address | address Target address that will receive the tokens |
| amount | uint256 | uint256 The amount mount of tokens to be transferred |
| data | bytes | bytes Optional data to send along with the call |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | whether the call correctly returned the expected magic value |

### _checkAndCallApprove

```solidity
function _checkAndCallApprove(address spender, uint256 amount, bytes data) internal returns (bool)
```

_Internal function to invoke `onApprovalReceived` on a target address
 The call is not executed if the target address is not a contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | address The address which will spend the funds |
| amount | uint256 | uint256 The amount of tokens to be spent |
| data | bytes | bytes Optional data to send along with the call |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | whether the call correctly returned the expected magic value |

### recoverERC20

```solidity
function recoverERC20(address token, address recipient, uint256 amount) external returns (bool)
```

_Sends `amount` of ERC20 `token` from contract address to `recipient`

Useful if someone sent ERC20 tokens to the contract address by mistake._

## IERC1363

_Interface of the ERC1363 standard, as defined in the
https://eips.ethereum.org/EIPS/eip-1363.

Standard functions a token contract and contracts working with tokens
 can implement to make a token Payable.

For an implementation, see https://github.com/vittominacori/erc1363-payable-token.

Note: Name adjusted to BSC network._

### transferAndCall

```solidity
function transferAndCall(address to, uint256 value) external returns (bool)
```

Transfer tokens from `msg.sender` to another address and then call `onTransferReceived` on receiver

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| to | address | address The address which you want to transfer to |
| value | uint256 | uint256 The amount of tokens to be transferred |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true unless throwing |

### transferAndCall

```solidity
function transferAndCall(address to, uint256 value, bytes data) external returns (bool)
```

Transfer tokens from `msg.sender` to another address and then call `onTransferReceived` on receiver

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| to | address | address The address which you want to transfer to |
| value | uint256 | uint256 The amount of tokens to be transferred |
| data | bytes | bytes Additional data with no specified format, sent in call to `to` |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true unless throwing |

### transferFromAndCall

```solidity
function transferFromAndCall(address from, address to, uint256 value) external returns (bool)
```

Transfer tokens from one address to another and then call `onTransferReceived` on receiver

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | address The address which you want to send tokens from |
| to | address | address The address which you want to transfer to |
| value | uint256 | uint256 The amount of tokens to be transferred |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true unless throwing |

### transferFromAndCall

```solidity
function transferFromAndCall(address from, address to, uint256 value, bytes data) external returns (bool)
```

Transfer tokens from one address to another and then call `onTransferReceived` on receiver

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | address The address which you want to send tokens from |
| to | address | address The address which you want to transfer to |
| value | uint256 | uint256 The amount of tokens to be transferred |
| data | bytes | bytes Additional data with no specified format, sent in call to `to` |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | true unless throwing |

### approveAndCall

```solidity
function approveAndCall(address spender, uint256 value) external returns (bool)
```

Approve the passed address to spend the specified amount of tokens on behalf of msg.sender
and then call `onApprovalReceived` on spender.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | address The address which will spend the funds |
| value | uint256 | uint256 The amount of tokens to be spent |

### approveAndCall

```solidity
function approveAndCall(address spender, uint256 value, bytes data) external returns (bool)
```

Approve the passed address to spend the specified amount of tokens on behalf of msg.sender
and then call `onApprovalReceived` on spender.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | address The address which will spend the funds |
| value | uint256 | uint256 The amount of tokens to be spent |
| data | bytes | bytes Additional data with no specified format, sent in call to `spender` |

## IERC1363Receiver

_Interface for any contract that wants to support `transferAndCall` or `transferFromAndCall`
 from ERC1363 token contracts._

### onTransferReceived

```solidity
function onTransferReceived(address operator, address from, uint256 value, bytes data) external returns (bytes4)
```

Handle the receipt of ERC1363 tokens

_Any ERC1363 smart contract calls this function on the recipient
after a `transfer` or a `transferFrom`. This function MAY throw to revert and reject the
transfer. Return of other than the magic value MUST result in the
transaction being reverted.
Note: the token contract address is always the message sender._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| operator | address | address The address which called `transferAndCall` or `transferFromAndCall` function |
| from | address | address The address which are token transferred from |
| value | uint256 | uint256 The amount of tokens transferred |
| data | bytes | bytes Additional data with no specified format |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes4 | `bytes4(keccak256("onTransferReceived(address,address,uint256,bytes)"))`  unless throwing |

## IERC1363Spender

_Interface for any contract that wants to support `approveAndCall`
 from ERC1363 token contracts._

### onApprovalReceived

```solidity
function onApprovalReceived(address owner, uint256 value, bytes data) external returns (bytes4)
```

Handle the approval of ERC1363 tokens

_Any ERC1363 smart contract calls this function on the recipient
after an `approve`. This function MAY throw to revert and reject the
approval. Return of other than the magic value MUST result in the
transaction being reverted.
Note: the token contract address is always the message sender._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | address The address which called `approveAndCall` function |
| value | uint256 | uint256 The amount of tokens to be spent |
| data | bytes | bytes Additional data with no specified format |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes4 | `bytes4(keccak256("onApprovalReceived(address,uint256,bytes)"))`  unless throwing |

## IERC165

_Interface of the ERC165 standard, as defined in the
https://eips.ethereum.org/EIPS/eip-165.

Implementers can declare support of contract interfaces, which can then be
queried by others.

For an implementation, see {ERC165}.

Note: Name adjusted to BSC network._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```

_Returns true if this contract implements the interface defined by
`interfaceId`. See the corresponding
https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified
to learn more about how these ids are created.

This function call must use less than 30 000 gas._

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

