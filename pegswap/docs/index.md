# Solidity API

## Swap

This contract implements EIP-712 for verifying signed messages

### EIP712Domain

```solidity
struct EIP712Domain {
  string name;
  string version;
  uint256 chainId;
  address verifyingContract;
}
```

### SwapRequest

```solidity
struct SwapRequest {
  uint256 fromChain;
  uint256 toChain;
  address operator;
  address recipient;
  uint256 amount;
  uint256 nonce;
}
```

### EIP712DOMAIN_TYPEHASH

```solidity
bytes32 EIP712DOMAIN_TYPEHASH
```

### SWAPREQUEST_TYPEHASH

```solidity
bytes32 SWAPREQUEST_TYPEHASH
```

### DOMAIN_SEPARATOR

```solidity
bytes32 DOMAIN_SEPARATOR
```

### constructor

```solidity
constructor() public
```

### getChainId

```solidity
function getChainId() public view returns (uint256)
```

_Returns the chain ID of the network the contract is currently deployed to._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | uint256 The chain ID of the network. |

### hash

```solidity
function hash(struct Swap.EIP712Domain eip712Domain) internal pure returns (bytes32)
```

_Returns the hash of an EIP712 domain._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| eip712Domain | struct Swap.EIP712Domain | An EIP712 domain. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | bytes32 The hash of the EIP712 domain. |

### hash

```solidity
function hash(struct Swap.SwapRequest swapRequest) internal pure returns (bytes32)
```

_Returns the hash of a swap request._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| swapRequest | struct Swap.SwapRequest | A swap request. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes32 | bytes32 The hash of the swap request. |

### verify

```solidity
function verify(struct Swap.SwapRequest swapRequest, uint8 v, bytes32 r, bytes32 s) public view returns (bool)
```

_Verifies a signature for a swap request._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| swapRequest | struct Swap.SwapRequest | A swap request. |
| v | uint8 | The recovery parameter of the signature. |
| r | bytes32 | The first half of the signature. |
| s | bytes32 | The second half of the signature. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | bool `true` if the signature is valid, `false` otherwise. |

### Claimed

```solidity
event Claimed(uint256 fromChain, uint256 toChain, address operator, address recipient, uint256 amount)
```

_Emitted when a swap request has been successfully claimed._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fromChain | uint256 | The chain the token is being swapped from. |
| toChain | uint256 | The chain the token is being swapped to. |
| operator | address | The address of the operator. |
| recipient | address | The address of the recipient. |
| amount | uint256 | The amount of tokens being swapped. |

### claim

```solidity
function claim(struct Swap.SwapRequest swapRequest, uint8 v, bytes32 r, bytes32 s) external
```

_Claims a swap request.
Requirements:
- The signature must be valid.
- The operator must be valid.
- The nonce must not have already been claimed._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| swapRequest | struct Swap.SwapRequest | A swap request. |
| v | uint8 | The recovery parameter of the signature. |
| r | bytes32 | The first half of the signature. |
| s | bytes32 | The second half of the signature. Emits `Clamed` If the swap request is successfully claimed. |

### isClaimed

```solidity
function isClaimed(uint256 fromChain, uint256 nonce) external view returns (bool)
```

_Returns whether a swap request with the given nonce from the given
chain has already been claimed._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| fromChain | uint256 | The chain the token is being swapped from. |
| nonce | uint256 | The nonce of the swap request. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | bool `true` if the swap request has been claimed, `false` |

### setInpulseXAddr

```solidity
function setInpulseXAddr(address inpulsex) external
```

_Sets `inpulsex` contract address.

Requirements:

- `inpulsex` should not be address(0)_

### SwapRequested

```solidity
event SwapRequested(uint256 toChain, address toAddress, uint256 amount, address requestedFrom, address operator, uint256 nonce)
```

### onTransferReceived

```solidity
function onTransferReceived(address requestedFrom, address from, uint256 value, bytes data) external returns (bytes4)
```

_Called when a transfer is received by the contract._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| requestedFrom | address | The address that requested the transfer. |
| from | address | The address that sent the transfer. |
| value | uint256 | The amount of tokens transferred. |
| data | bytes | The data associated with the transfer. |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes4 | bytes4 The selector for the onTransferReceived function from the IERC1363Receiver interface. Reverts if the message sender is not the InpulseX token. Emits `SwapRequested` with information about the swap request. |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure returns (bool)
```

_See {IERC165-supportsInterface}._

### recoverTokens

```solidity
function recoverTokens(address token, address recipient, uint256 amount) external returns (bool)
```

_Sends `amount` of `token` from contract address to `recipient`

Useful if someone sent erc20 tokens to the contract address by mistake._

## Operatable

_Contract module which provides a basic access control mechanism, where
there is are multiple accounts that can be granted exclusive access to
specific functions._

### constructor

```solidity
constructor() public
```

_Initializes the contract setting the deployer as the initial owner._

### isOperator

```solidity
function isOperator(address addr) public view returns (bool)
```

_Returns the address of the current owner._

### setIsOperator

```solidity
function setIsOperator(address addr, bool state) public
```

_Returns the address of the current owner._

### onlyOperators

```solidity
modifier onlyOperators()
```

_Throws if called by any account other than the owner._

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

