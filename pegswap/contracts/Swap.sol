//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

import "./libraries/ECDSA.sol";
import "./libraries/Context.sol";
import "./libraries/Ownable.sol";
import "./libraries/Operatable.sol";

import "./interfaces/IERC20.sol";
import "./interfaces/IERC165.sol";
import "./interfaces/IERC1363Receiver.sol";

/**
 * This contract implements EIP-712 for verifying signed messages
 */
contract Swap is Context, Ownable, Operatable, IERC165, IERC1363Receiver {
    mapping(uint256 => uint256) private _nonces;
    mapping(uint256 => mapping(uint256 => bool)) private _usedNonces;

    IERC20 private _inpulsex;

    struct EIP712Domain {
        string name;
        string version;
        uint256 chainId;
        address verifyingContract;
    }

    struct SwapRequest {
        uint256 fromChain;
        uint256 toChain;
        address operator;
        address recipient;
        uint256 amount;
        uint256 nonce;
    }

    bytes32 constant EIP712DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    bytes32 constant SWAPREQUEST_TYPEHASH =
        keccak256(
            "SwapRequest(uint256 fromChain,uint256 toChain,address operator,address recipient,uint256 amount,uint256 nonce)"
        );

    bytes32 DOMAIN_SEPARATOR;

    constructor() {
        DOMAIN_SEPARATOR = hash(
            EIP712Domain({
                name: "InpulseX PegSwap Router",
                version: "1",
                chainId: getChainId(),
                verifyingContract: address(this)
            })
        );
    }

    function getChainId() public view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }

    function hash(EIP712Domain memory eip712Domain)
        internal
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encode(
                    EIP712DOMAIN_TYPEHASH,
                    keccak256(bytes(eip712Domain.name)),
                    keccak256(bytes(eip712Domain.version)),
                    eip712Domain.chainId,
                    eip712Domain.verifyingContract
                )
            );
    }

    function hash(SwapRequest memory swapRequest)
        internal
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encode(
                    SWAPREQUEST_TYPEHASH,
                    swapRequest.fromChain,
                    swapRequest.toChain,
                    swapRequest.operator,
                    swapRequest.recipient,
                    swapRequest.amount,
                    swapRequest.nonce
                )
            );
    }

    function verify(
        SwapRequest memory swapRequest,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public view returns (bool) {
        // Note: we need to use `encodePacked` here instead of `encode`.
        bytes32 digest = keccak256(
            abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, hash(swapRequest))
        );
        return ECDSA.recover(digest, v, r, s) == swapRequest.operator;
    }

    event Claimed(
        uint256 fromChain,
        uint256 toChain,
        address operator,
        address recipient,
        uint256 amount
    );

    function claim(
        SwapRequest memory swapRequest,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        bool isValid = verify(swapRequest, v, r, s);
        require(isValid, "PegSwap: Signature is not valid");

        bool isFromValidOperator = isOperator(swapRequest.operator);
        require(isFromValidOperator, "PegSwap: Operator not valid");

        bool claimed = _usedNonces[swapRequest.fromChain][swapRequest.nonce];
        require(!claimed, "PegSwap: Already claimed");

        _usedNonces[swapRequest.fromChain][swapRequest.nonce] = true;

        bool success = _inpulsex.transfer(
            swapRequest.recipient,
            swapRequest.amount
        );

        require(success, "PegSwap: TransferFrom failed");

        emit Claimed(
            swapRequest.fromChain,
            swapRequest.toChain,
            swapRequest.operator,
            swapRequest.recipient,
            swapRequest.amount
        );
    }

    function isClaimed(uint256 fromChain, uint256 nonce)
        external
        view
        returns (bool)
    {
        return _usedNonces[fromChain][nonce];
    }

    /**
     * @dev Sets `inpulsex` contract address.
     *
     * Requirements:
     *
     * - `inpulsex` should not be address(0)
     */
    function setInpulseXAddr(address inpulsex) external onlyOwner {
        require(inpulsex != address(0), "PegSwap: Cannot set InpulseX to 0x0");
        _inpulsex = IERC20(inpulsex);
    }

    event SwapRequested(
        uint256 toChain,
        address toAddress,
        uint256 amount,
        address requestedFrom,
        address operator,
        uint256 nonce
    );

    function onTransferReceived(
        address requestedFrom,
        address from,
        uint256 value,
        bytes memory data
    ) external returns (bytes4) {
        require(
            _msgSender() == address(_inpulsex),
            "PegSwap: Message sender is not the InpulseX token"
        );

        (uint256 toChain, address operator) = abi.decode(
            data,
            (uint256, address)
        );

        uint256 nonce = _nonces[toChain];
        _nonces[toChain] = _nonces[toChain] + 1;

        emit SwapRequested(
            toChain,
            from,
            value,
            requestedFrom,
            operator,
            nonce
        );

        return IERC1363Receiver(this).onTransferReceived.selector;
    }

    /* ERC165 methods */

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
        return interfaceId == type(IERC1363Receiver).interfaceId;
    }

    /**
     * @dev Sends `amount` of `token` from contract address to `recipient`
     *
     * Useful if someone sent bep20 tokens to the contract address by mistake.
     */
    function recoverTokens(
        address token,
        address recipient,
        uint256 amount
    ) external onlyOwner returns (bool) {
        return IERC20(token).transfer(recipient, amount);
    }
}
