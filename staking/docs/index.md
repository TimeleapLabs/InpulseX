# Solidity API

## BaseStaking

### _stakePoolWeight

```solidity
uint256 _stakePoolWeight
```

### _rewardPoolSize

```solidity
uint256 _rewardPoolSize
```

### _unlockTime

```solidity
uint256 _unlockTime
```

### _penaltyAddress

```solidity
address _penaltyAddress
```

### _exceptions

```solidity
mapping(address => bool) _exceptions
```

### _penalties

```solidity
mapping(address => uint256) _penalties
```

### _stake

```solidity
mapping(address => uint256) _stake
```

### _stakeWeight

```solidity
mapping(address => uint256) _stakeWeight
```

### Staked

```solidity
event Staked(address user, uint256 amount)
```

### UnStaked

```solidity
event UnStaked(address user, uint256 amount)
```

### StakingTokenChanged

```solidity
event StakingTokenChanged(address token)
```

### RewardTokenChanged

```solidity
event RewardTokenChanged(address token)
```

### RewardsAdded

```solidity
event RewardsAdded(uint256 amount)
```

### RewardsRecovered

```solidity
event RewardsRecovered(uint256 amount)
```

### constructor

```solidity
constructor() internal
```

### UnlockTimeChanged

```solidity
event UnlockTimeChanged(uint256 timestamp)
```

### setUnlockTime

```solidity
function setUnlockTime(uint256 timestamp) external
```

_Sets the unlock time of this staking contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| timestamp | uint256 | The unlock time of the contract |

### getUnlockTime

```solidity
function getUnlockTime() external view returns (uint256)
```

_Allows reading the current unlock time of the contract_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | uint256 The current unlock "timestamp" |

### PenaltyAddressChanged

```solidity
event PenaltyAddressChanged(address addr)
```

### setPenaltyAddress

```solidity
function setPenaltyAddress(address penalty) external
```

_Sets the penalty collection address for early unstakings_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| penalty | address | The address that collects the penalties |

### canUnstake

```solidity
function canUnstake(address user) public view returns (bool)
```

_Returns true or false depending on if the user can unstake_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | bool true if the user can unstake |

### PenaltySetForUser

```solidity
event PenaltySetForUser(address user, uint256 penalty)
```

### allowUnstakeWithPenalty

```solidity
function allowUnstakeWithPenalty(address user, uint256 penalty) external
```

_Allow `user` to unstake early with an optional penalty_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user to add to exceptions |
| penalty | uint256 | The penalty percentage (e.g. 5 means 5% penalty) |

### disallowUnstakeWithPenalty

```solidity
function disallowUnstakeWithPenalty(address user) external
```

_Disallows user from unstaking early (default behavior)_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user to remove from exceptions |

### getStake

```solidity
function getStake(address user) external view returns (uint256)
```

_Returns the amount of tokens currently staked by the user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user staking tokens |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | uint256 Amount of tokens staked by the `user` |

### getRewardSize

```solidity
function getRewardSize(address user) public view returns (uint256)
```

_Get the current reward size for `user`_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user |

### recordStakeWeight

```solidity
function recordStakeWeight(address user, uint256 amount) internal
```

_Sets the stake weight for a user stake event_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The `user` to set the stake time for |
| amount | uint256 | The amount of tokens staked in this event |

### sendRewards

```solidity
function sendRewards(address user, uint256 amount) internal virtual
```

_Sends staking rewards to a user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user to send the rewards to |
| amount | uint256 | Amount of tokens to transfer to the user |

## Dummy1155

### constructor

```solidity
constructor() public
```

## Dummy721

### constructor

```solidity
constructor() public
```

## Dummy20

### constructor

```solidity
constructor() public
```

## Dummy1363

### constructor

```solidity
constructor() public
```

### transferAndCall

```solidity
function transferAndCall(address recipient, uint256 amount, bytes data) public returns (bool)
```

## ERC1155RewardsNonReceiver

### _rewardToken

```solidity
contract IERC1155 _rewardToken
```

### _rewardNftId

```solidity
uint256 _rewardNftId
```

### RewardNftTokenChanged

```solidity
event RewardNftTokenChanged(address token, uint256 nftId)
```

### setRewardToken

```solidity
function setRewardToken(address token, uint256 id) external
```

_Allows setting the reward token._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the reward token. |
| id | uint256 | The ID of the reward token. |

### getRewardToken

```solidity
function getRewardToken() external view returns (address, uint256)
```

_Returns the address of the reward token._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | (address, uint256) The address and ID of the reward token. |
| [1] | uint256 |  |

### addReward

```solidity
function addReward(uint256 amount) external
```

_Allows adding rewards to the pool._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of rewards to be added to the pool. |

### recoverRewards

```solidity
function recoverRewards(uint256 amount) external
```

_Allows recovering rewards from the pool._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of rewards to be recovered from the pool. |

### sendRewards

```solidity
function sendRewards(address user, uint256 amount) internal
```

_Sends rewards to a user._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user. |
| amount | uint256 | The amount of rewards to be sent to the user. |

## ERC1155Rewards

### onERC1155Received

```solidity
function onERC1155Received(address, address, uint256, uint256, bytes) external view returns (bytes4)
```

_See {IERC1155-onERC1155Received}._

### onERC1155BatchReceived

```solidity
function onERC1155BatchReceived(address, address, uint256[], uint256[], bytes) external pure returns (bytes4)
```

_See {IERC1155-onERC1155BatchReceived}._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC20Rewards

### _rewardToken

```solidity
contract IERC20 _rewardToken
```

### setRewardToken

```solidity
function setRewardToken(address token) external
```

_Allows setting the reward token._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The address of the reward token. |

### getRewardToken

```solidity
function getRewardToken() external view returns (address)
```

_Returns the address of the reward token._

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address The address of the reward token. |

### addReward

```solidity
function addReward(uint256 amount) external
```

_Allows adding rewards to the pool._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of rewards to be added to the pool. |

### recoverRewards

```solidity
function recoverRewards(uint256 amount) external
```

_Allows recovering rewards from the pool._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The amount of rewards to be recovered from the pool. |

### sendRewards

```solidity
function sendRewards(address user, uint256 amount) internal
```

_Sends rewards to a user._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | The address of the user. |
| amount | uint256 | The amount of rewards to be sent to the user. |

## ERC1155Staking

### StakingNftTokenChanged

```solidity
event StakingNftTokenChanged(address token, uint256 nftId)
```

### setStakingToken

```solidity
function setStakingToken(address token, uint256 nftId) external
```

_Set the token used for staking_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | Address of the token contract |
| nftId | uint256 | Id of the NFT to accept for stake Reverts if the token is set to address(0) |

### getStakingToken

```solidity
function getStakingToken() external view returns (address, uint256)
```

_Get the address of the token used for staking_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | (address, uint256) Address of the token contract and the NFT ID |
| [1] | uint256 |  |

### stake

```solidity
function stake(uint256 amount) external
```

_Transfers `amount` tokens from the user to this contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | Amount of tokens being staked Reverts if `amount` is not greater than 0 Reverts if staking window is smaller than the block timestamp |

### unstake

```solidity
function unstake() external
```

_Unstake tokens

Reverts if user stake amount is not greater than 0
Reverts if block timestamp is not bigger than the unlock time
or the user is not allowed to unstake early

A penalty may be applied if the user removes their stake early_

### onERC1155Received

```solidity
function onERC1155Received(address, address, uint256, uint256, bytes) external view returns (bytes4)
```

_See {IERC1155-onERC1155Received}._

### onERC1155BatchReceived

```solidity
function onERC1155BatchReceived(address, address, uint256[], uint256[], bytes) external pure returns (bytes4)
```

_See {IERC1155-onERC1155BatchReceived}._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC1155StakerERC20Rewarder

## ERC1155StakerERC1155Rewarder

## ERC1363Staking

### setStakingToken

```solidity
function setStakingToken(address token) external
```

_Set the token used for staking_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | Address of the token contract Reverts if the token is set to address(0) |

### getStakingToken

```solidity
function getStakingToken() external view returns (address)
```

_Get the address of the token used for staking_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address Address of the token contract |

### unstake

```solidity
function unstake() external
```

_Unstake tokens

Reverts if user stake amount is not greater than 0
Reverts if block timestamp is not bigger than the unlock time
or the user is not allowed to unstake early

A penalty may be applied if the user removes their stake early_

### onTransferReceived

```solidity
function onTransferReceived(address, address user, uint256 amount, bytes) external returns (bytes4)
```

_Handle incoming transfers of staking tokens_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
|  | address |  |
| user | address | Address of the user staking tokens |
| amount | uint256 | Amount of tokens being staked |
|  | bytes |  |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes4 | bytes4 Signature of the method in the receiver contract Reverts if `amount` is not bigger than 0 Reverts if staking window is smaller than the block timestamp Reverts if the message sender is not the staking token |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC1363StakerERC20Rewarder

## ERC1363StakerERC1155Rewarder

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC20Staking

### setStakingToken

```solidity
function setStakingToken(address token) external
```

_Set the token used for staking_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | Address of the token contract Reverts if the token is set to address(0) |

### getStakingToken

```solidity
function getStakingToken() external view returns (address)
```

_Get the address of the token used for staking_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address Address of the token contract |

### stake

```solidity
function stake(uint256 amount) external
```

_Transfers `amount` tokens from the user to this contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | Amount of tokens being staked Reverts if `amount` is not greater than 0 Reverts if staking window is smaller than the block timestamp |

### unstake

```solidity
function unstake() external
```

_Unstake tokens

Reverts if user stake amount is not greater than 0
Reverts if block timestamp is not bigger than the unlock time
or the user is not allowed to unstake early

A penalty may be applied if the user removes their stake early_

## ERC20StakerERC20Rewarder

## ERC20StakerERC1155Rewarder

## ERC721Staking

### _stakeIds

```solidity
mapping(address => uint256[]) _stakeIds
```

### setStakingToken

```solidity
function setStakingToken(address token) external
```

_Set the token used for staking_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | Address of the token contract Reverts if the token is set to address(0) |

### getStakingToken

```solidity
function getStakingToken() external view returns (address)
```

_Get the address of the token used for staking_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | address Address of the token contract |

### stake

```solidity
function stake(uint256 id) public
```

_Transfers NFT with `id` from the user to this contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | uint256 | ID of the NFT to stake Reverts if staking window is smaller than the block timestamp |

### stakeMany

```solidity
function stakeMany(uint256[] ids, uint256 length) external
```

_Transfers NFT with `id` from the user to this contract_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| ids | uint256[] | IDs of the NFTs to stake |
| length | uint256 | Number of NFTs to stake Reverts if staking window is smaller than the block timestamp |

### unstake

```solidity
function unstake() external
```

_Unstake tokens

Reverts if user stake amount is not greater than 0
Reverts if block timestamp is not bigger than the unlock time
or the user is not allowed to unstake early

A penalty may be applied if the user removes their stake early_

### getStakeIds

```solidity
function getStakeIds(address user) external view returns (uint256[])
```

_Returns the NFT IDs currently staked by the user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| user | address | Address of the user staking tokens |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256[] | uint256[] NFT IDs staked by the `user` |

### onERC721Received

```solidity
function onERC721Received(address, address, uint256, bytes) external view returns (bytes4)
```

_See {IERC721-onERC721Received}._

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool)
```

_See {IERC165-supportsInterface}._

## ERC721StakerERC20Rewarder

## ERC721StakerERC1155Rewarder

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) public pure returns (bool)
```

_See {IERC165-supportsInterface}._

## NFTSweep

### performNftSweep

```solidity
function performNftSweep(address nft, address user, uint256 start, uint256 end) external view returns (uint256[], uint256)
```

_Returns a list of NFTs owned by the user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| nft | address | Address of the ERC721 NFT contract |
| user | address | Address of the user |
| start | uint256 | Start NFT ID for lookup |
| end | uint256 | End NFT ID to lookup |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256[] | uint256[] NFTs owned by `user` |
| [1] | uint256 |  |

### performEnumerableNftSweep

```solidity
function performEnumerableNftSweep(address nft, address user) external view returns (uint256[])
```

_Returns a list of NFTs owned by the user_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| nft | address | Address of the ERC721 NFT contract |
| user | address | Address of the user |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256[] | uint256[] NFTs owned by `user` |

## IERC1155

### TransferSingle

```solidity
event TransferSingle(address _operator, address _from, address _to, uint256 _id, uint256 _value)
```

_Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).
        The `_operator` argument MUST be the address of an account/contract that is approved to make the transfer (SHOULD be msg.sender).
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_id` argument MUST be the token type being transferred.
        The `_value` argument MUST be the number of tokens the holder balance is decreased by and match what the recipient balance is increased by.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address)._

### TransferBatch

```solidity
event TransferBatch(address _operator, address _from, address _to, uint256[] _ids, uint256[] _values)
```

_Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).      
        The `_operator` argument MUST be the address of an account/contract that is approved to make the transfer (SHOULD be msg.sender).
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_ids` argument MUST be the list of tokens being transferred.
        The `_values` argument MUST be the list of number of tokens (matching the list and order of tokens specified in _ids) the holder balance is decreased by and match what the recipient balance is increased by.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address)._

### ApprovalForAll

```solidity
event ApprovalForAll(address _owner, address _operator, bool _approved)
```

_MUST emit when approval for a second party/operator address to manage all tokens for an owner address is enabled or disabled (absence of an event assumes disabled)._

### URI

```solidity
event URI(string _value, uint256 _id)
```

_MUST emit when the URI is updated for a token ID.
        URIs are defined in RFC 3986.
        The URI MUST point to a JSON file that conforms to the "ERC-1155 Metadata URI JSON Schema"._

### safeTransferFrom

```solidity
function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes _data) external
```

Transfers `_value` amount of an `_id` from the `_from` address to the `_to` address specified (with safety call).
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address.
        MUST revert if balance of holder for token `_id` is lower than the `_value` sent.
        MUST revert on any other error.
        MUST emit the `TransferSingle` event to reflect the balance change (see "Safe Transfer Rules" section of the standard).
        After the above conditions are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call `onERC1155Received` on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).        
        @param _from    Source address
        @param _to      Target address
        @param _id      ID of the token type
        @param _value   Transfer amount
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to `onERC1155Received` on `_to`

### safeBatchTransferFrom

```solidity
function safeBatchTransferFrom(address _from, address _to, uint256[] _ids, uint256[] _values, bytes _data) external
```

Transfers `_values` amount(s) of `_ids` from the `_from` address to the `_to` address specified (with safety call).
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address.
        MUST revert if length of `_ids` is not the same as length of `_values`.
        MUST revert if any of the balance(s) of the holder(s) for token(s) in `_ids` is lower than the respective amount(s) in `_values` sent to the recipient.
        MUST revert on any other error.        
        MUST emit `TransferSingle` or `TransferBatch` event(s) such that all the balance changes are reflected (see "Safe Transfer Rules" section of the standard).
        Balance changes and events MUST follow the ordering of the arrays (_ids[0]/_values[0] before _ids[1]/_values[1], etc).
        After the above conditions for the transfer(s) in the batch are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call the relevant `ERC1155TokenReceiver` hook(s) on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).                      
        @param _from    Source address
        @param _to      Target address
        @param _ids     IDs of each token type (order and length must match _values array)
        @param _values  Transfer amounts per token type (order and length must match _ids array)
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to the `ERC1155TokenReceiver` hook(s) on `_to`

### balanceOf

```solidity
function balanceOf(address _owner, uint256 _id) external view returns (uint256)
```

Get the balance of an account's tokens.
        @param _owner  The address of the token holder
        @param _id     ID of the token
        @return        The _owner's balance of the token type requested

### balanceOfBatch

```solidity
function balanceOfBatch(address[] _owners, uint256[] _ids) external view returns (uint256[])
```

Get the balance of multiple account/token pairs
        @param _owners The addresses of the token holders
        @param _ids    ID of the tokens
        @return        The _owner's balance of the token types requested (i.e. balance for each (owner, id) pair)

### setApprovalForAll

```solidity
function setApprovalForAll(address _operator, bool _approved) external
```

Enable or disable approval for a third party ("operator") to manage all of the caller's tokens.
        @dev MUST emit the ApprovalForAll event on success.
        @param _operator  Address to add to the set of authorized operators
        @param _approved  True if the operator is approved, false to revoke approval

### isApprovedForAll

```solidity
function isApprovedForAll(address _owner, address _operator) external view returns (bool)
```

Queries the approval status of an operator for a given owner.
        @param _owner     The owner of the tokens
        @param _operator  Address of authorized operator
        @return           True if the operator is approved, false if not

## IERC1155Receiver

Note: The ERC-165 identifier for this interface is 0x4e2312e0.

### onERC1155Received

```solidity
function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes _data) external returns (bytes4)
```

Handle the receipt of a single ERC1155 token type.
        @dev An ERC1155-compliant smart contract MUST call this function on the token recipient contract, at the end of a `safeTransferFrom` after the balance has been updated.        
        This function MUST return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` (i.e. 0xf23a6e61) if it accepts the transfer.
        This function MUST revert if it rejects the transfer.
        Return of any other value than the prescribed keccak256 generated value MUST result in the transaction being reverted by the caller.
        @param _operator  The address which initiated the transfer (i.e. msg.sender)
        @param _from      The address which previously owned the token
        @param _id        The ID of the token being transferred
        @param _value     The amount of tokens being transferred
        @param _data      Additional data with no specified format
        @return           `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`

### onERC1155BatchReceived

```solidity
function onERC1155BatchReceived(address _operator, address _from, uint256[] _ids, uint256[] _values, bytes _data) external returns (bytes4)
```

Handle the receipt of multiple ERC1155 token types.
        @dev An ERC1155-compliant smart contract MUST call this function on the token recipient contract, at the end of a `safeBatchTransferFrom` after the balances have been updated.        
        This function MUST return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` (i.e. 0xbc197c81) if it accepts the transfer(s).
        This function MUST revert if it rejects the transfer(s).
        Return of any other value than the prescribed keccak256 generated value MUST result in the transaction being reverted by the caller.
        @param _operator  The address which initiated the batch transfer (i.e. msg.sender)
        @param _from      The address which previously owned the token
        @param _ids       An array containing ids of each token being transferred (order and length must match _values array)
        @param _values    An array containing amounts of each token being transferred (order and length must match _ids array)
        @param _data      Additional data with no specified format
        @return           `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`

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

## IERC721

_See https://eips.ethereum.org/EIPS/eip-721
 Note: the ERC-165 identifier for this interface is 0x80ac58cd._

### Transfer

```solidity
event Transfer(address _from, address _to, uint256 _tokenId)
```

_This emits when ownership of any NFT changes by any mechanism.
 This event emits when NFTs are created (`from` == 0) and destroyed
 (`to` == 0). Exception: during contract creation, any number of NFTs
 may be created and assigned without emitting Transfer. At the time of
 any transfer, the approved address for that NFT (if any) is reset to none._

### Approval

```solidity
event Approval(address _owner, address _approved, uint256 _tokenId)
```

_This emits when the approved address for an NFT is changed or
 reaffirmed. The zero address indicates there is no approved address.
 When a Transfer event emits, this also indicates that the approved
 address for that NFT (if any) is reset to none._

### ApprovalForAll

```solidity
event ApprovalForAll(address _owner, address _operator, bool _approved)
```

_This emits when an operator is enabled or disabled for an owner.
 The operator can manage all NFTs of the owner._

### balanceOf

```solidity
function balanceOf(address _owner) external view returns (uint256)
```

Count all NFTs assigned to an owner

_NFTs assigned to the zero address are considered invalid, and this
 function throws for queries about the zero address._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _owner | address | An address for whom to query the balance |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The number of NFTs owned by `_owner`, possibly zero |

### ownerOf

```solidity
function ownerOf(uint256 _tokenId) external view returns (address)
```

Find the owner of an NFT

_NFTs assigned to zero address are considered invalid, and queries
 about them do throw._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _tokenId | uint256 | The identifier for an NFT |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The address of the owner of the NFT |

### safeTransferFrom

```solidity
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable
```

Transfers the ownership of an NFT from one address to another address

_Throws unless `msg.sender` is the current owner, an authorized
 operator, or the approved address for this NFT. Throws if `_from` is
 not the current owner. Throws if `_to` is the zero address. Throws if
 `_tokenId` is not a valid NFT. When transfer is complete, this function
 checks if `_to` is a smart contract (code size > 0). If so, it calls
 `onERC721Received` on `_to` and throws if the return value is not
 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _from | address | The current owner of the NFT |
| _to | address | The new owner |
| _tokenId | uint256 | The NFT to transfer |
| data | bytes | Additional data with no specified format, sent in call to `_to` |

### safeTransferFrom

```solidity
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable
```

Transfers the ownership of an NFT from one address to another address

_This works identically to the other function with an extra data parameter,
 except this function just sets data to ""._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _from | address | The current owner of the NFT |
| _to | address | The new owner |
| _tokenId | uint256 | The NFT to transfer |

### transferFrom

```solidity
function transferFrom(address _from, address _to, uint256 _tokenId) external payable
```

Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
 TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
 THEY MAY BE PERMANENTLY LOST

_Throws unless `msg.sender` is the current owner, an authorized
 operator, or the approved address for this NFT. Throws if `_from` is
 not the current owner. Throws if `_to` is the zero address. Throws if
 `_tokenId` is not a valid NFT._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _from | address | The current owner of the NFT |
| _to | address | The new owner |
| _tokenId | uint256 | The NFT to transfer |

### approve

```solidity
function approve(address _approved, uint256 _tokenId) external payable
```

Change or reaffirm the approved address for an NFT

_The zero address indicates there is no approved address.
 Throws unless `msg.sender` is the current NFT owner, or an authorized
 operator of the current owner._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _approved | address | The new approved NFT controller |
| _tokenId | uint256 | The NFT to approve |

### setApprovalForAll

```solidity
function setApprovalForAll(address _operator, bool _approved) external
```

Enable or disable approval for a third party ("operator") to manage
 all of `msg.sender`'s assets

_Emits the ApprovalForAll event. The contract MUST allow
 multiple operators per owner._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _operator | address | Address to add to the set of authorized operators |
| _approved | bool | True if the operator is approved, false to revoke approval |

### getApproved

```solidity
function getApproved(uint256 _tokenId) external view returns (address)
```

Get the approved address for a single NFT

_Throws if `_tokenId` is not a valid NFT._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _tokenId | uint256 | The NFT to find the approved address for |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | The approved address for this NFT, or the zero address if there is none |

### isApprovedForAll

```solidity
function isApprovedForAll(address _owner, address _operator) external view returns (bool)
```

Query if an address is an authorized operator for another address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _owner | address | The address that owns the NFTs |
| _operator | address | The address that acts on behalf of the owner |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if `_operator` is an approved operator for `_owner`, false otherwise |

## IERC721Receiver

_Note: the ERC-165 identifier for this interface is 0x150b7a02._

### onERC721Received

```solidity
function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns (bytes4)
```

Handle the receipt of an NFT

_The ERC721 smart contract calls this function on the recipient
 after a `transfer`. This function MAY throw to revert and reject the
 transfer. Return of other than the magic value MUST result in the
 transaction being reverted.
 Note: the contract address is always the message sender._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _operator | address | The address which called `safeTransferFrom` function |
| _from | address | The address which previously owned the token |
| _tokenId | uint256 | The NFT identifier which is being transferred |
| _data | bytes | Additional data with no specified format |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes4 | `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`  unless throwing |

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

## Context

### constructor

```solidity
constructor() public
```

### _msgSender

```solidity
function _msgSender() internal view returns (address)
```

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

## Address

_Collection of functions related to the address type_

### isContract

```solidity
function isContract(address account) internal view returns (bool)
```

_Returns true if `account` is a contract.

[IMPORTANT]
====
It is unsafe to assume that an address for which this function returns
false is an externally-owned account (EOA) and not a contract.

Among others, `isContract` will return false for the following
types of addresses:

 - an externally-owned account
 - a contract in construction
 - an address where a contract will be created
 - an address where a contract lived, but was destroyed
====

[IMPORTANT]
====
You shouldn't rely on `isContract` to protect against flash loan attacks!

Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
constructor.
====_

