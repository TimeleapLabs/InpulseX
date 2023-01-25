//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./interfaces/IERC20.sol";
import "./interfaces/IERC165.sol";
import "./interfaces/IERC1363.sol";
import "./interfaces/IERC1363Receiver.sol";
import "./interfaces/IERC1363Spender.sol";

import "./libraries/Address.sol";
import "./libraries/Context.sol";
import "./libraries/Ownable.sol";

contract InpulseX is Context, IERC20, IERC165, IERC1363, Ownable {
    using Address for address;
    /* ERC20 related */

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    uint8 private _decimals;

    string private _symbol;
    string private _name;

    /* Security features */
    bool _started;

    constructor() {
        _name = "InpulseX";
        _symbol = "IPX";

        /**
         * Define a total supply of 10,000,000,000 tokens
         * with a decimal accuracy of 18 places
         */

        _decimals = 18;
        _totalSupply = 10e9 * 1e18;
        _balances[msg.sender] = _totalSupply;

        emit Transfer(address(0), msg.sender, _totalSupply);

        /**
         * Security feature: prevent transfers before the
         * migration is finished and liquidity is provided
         */

        _started = false;
    }

    /**
     * @dev Returns the contract owner.
     */
    function getOwner() external view returns (address) {
        return owner();
    }

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev See {ERC20-totalSupply}.
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {ERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {ERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {ERC20-allowance}.
     */
    function allowance(address addr, address spender)
        external
        view
        returns (uint256)
    {
        return _allowances[addr][spender];
    }

    /**
     * @dev See {ERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {ERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        require(
            _allowances[sender][_msgSender()] > amount,
            "ERC20: transfer amount exceeds allowance"
        );
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()] - amount
        );
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {ERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue)
        external
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender] + addedValue
        );
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {ERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue)
        external
        returns (bool)
    {
        require(
            _allowances[_msgSender()][spender] > subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender] - subtractedValue
        );
        return true;
    }

    event Reflect(uint256 amount);

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     * Emits a {Reflect} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - `amount` should not exceed the maximum allowed
     * - `amount` should not cause the recipient balance
                  to get bigger than the maximum allowed
       - trading should be open
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_started || sender == owner(), "InpulseX: trades not open yet");
        require(_balances[sender] > amount, "ERC20: insufficient balance");

        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;

        emit Transfer(sender, recipient, amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `addr`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `addr` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address addr,
        address spender,
        uint256 amount
    ) internal {
        require(addr != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[addr][spender] = amount;
        emit Approval(addr, spender, amount);
    }

    /* ERC165 methods */

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        external
        pure
        returns (bool)
    {
        return interfaceId == type(IERC1363).interfaceId;
    }

    /* ERC1363 methods */

    /**
     * @dev Transfer tokens to a specified address and then execute a callback on recipient.
     * @param recipient The address to transfer to.
     * @param amount The amount to be transferred.
     * @return A boolean that indicates if the operation was successful.
     */
    function transferAndCall(address recipient, uint256 amount)
        external
        returns (bool)
    {
        return transferAndCall(recipient, amount, "");
    }

    /**
     * @dev Transfer tokens to a specified address and then execute a callback on recipient.
     * @param recipient The address to transfer to
     * @param amount The amount to be transferred
     * @param data Additional data with no specified format
     * @return A boolean that indicates if the operation was successful.
     */
    function transferAndCall(
        address recipient,
        uint256 amount,
        bytes memory data
    ) public returns (bool) {
        transfer(recipient, amount);
        require(
            _checkAndCallTransfer(_msgSender(), recipient, amount, data),
            "ERC1363: _checkAndCallTransfer reverts"
        );
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another and then execute a callback on recipient.
     * @param sender The address which you want to send tokens from
     * @param recipient The address which you want to transfer to
     * @param amount The amount of tokens to be transferred
     * @return A boolean that indicates if the operation was successful.
     */
    function transferFromAndCall(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        return transferFromAndCall(sender, recipient, amount, "");
    }

    /**
     * @dev Transfer tokens from one address to another and then execute a callback on recipient.
     * @param sender The address which you want to send tokens from
     * @param recipient The address which you want to transfer to
     * @param amount The amount of tokens to be transferred
     * @param data Additional data with no specified format
     * @return A boolean that indicates if the operation was successful.
     */
    function transferFromAndCall(
        address sender,
        address recipient,
        uint256 amount,
        bytes memory data
    ) public returns (bool) {
        transferFrom(sender, recipient, amount);
        require(
            _checkAndCallTransfer(sender, recipient, amount, data),
            "ERC1363: _checkAndCallTransfer reverts"
        );
        return true;
    }

    /**
     * @dev Approve spender to transfer tokens and then execute a callback on recipient.
     * @param spender The address allowed to transfer to
     * @param amount The amount allowed to be transferred
     * @return A boolean that indicates if the operation was successful.
     */
    function approveAndCall(address spender, uint256 amount)
        external
        returns (bool)
    {
        return approveAndCall(spender, amount, "");
    }

    /**
     * @dev Approve spender to transfer tokens and then execute a callback on recipient.
     * @param spender The address allowed to transfer to.
     * @param amount The amount allowed to be transferred.
     * @param data Additional data with no specified format.
     * @return A boolean that indicates if the operation was successful.
     */
    function approveAndCall(
        address spender,
        uint256 amount,
        bytes memory data
    ) public returns (bool) {
        approve(spender, amount);
        require(
            _checkAndCallApprove(spender, amount, data),
            "ERC1363: _checkAndCallApprove reverts"
        );
        return true;
    }

    /**
     * @dev Internal function to invoke `onTransferReceived` on a target address
     *  The call is not executed if the target address is not a contract
     * @param sender address Representing the previous owner of the given token value
     * @param recipient address Target address that will receive the tokens
     * @param amount uint256 The amount mount of tokens to be transferred
     * @param data bytes Optional data to send along with the call
     * @return whether the call correctly returned the expected magic value
     */
    function _checkAndCallTransfer(
        address sender,
        address recipient,
        uint256 amount,
        bytes memory data
    ) internal returns (bool) {
        if (!recipient.isContract()) {
            return false;
        }
        bytes4 retval = IERC1363Receiver(recipient).onTransferReceived(
            _msgSender(),
            sender,
            amount,
            data
        );
        return (retval ==
            IERC1363Receiver(recipient).onTransferReceived.selector);
    }

    /**
     * @dev Internal function to invoke `onApprovalReceived` on a target address
     *  The call is not executed if the target address is not a contract
     * @param spender address The address which will spend the funds
     * @param amount uint256 The amount of tokens to be spent
     * @param data bytes Optional data to send along with the call
     * @return whether the call correctly returned the expected magic value
     */
    function _checkAndCallApprove(
        address spender,
        uint256 amount,
        bytes memory data
    ) internal returns (bool) {
        if (!spender.isContract()) {
            return false;
        }
        bytes4 retval = IERC1363Spender(spender).onApprovalReceived(
            _msgSender(),
            amount,
            data
        );
        return (retval == IERC1363Spender(spender).onApprovalReceived.selector);
    }

    /**
     * @dev Sets the trading to open, allows making transfers.
     */
    function openTrades() external onlyOwner {
        _started = true;
    }

    /**
     * @dev Sends `amount` of ERC20 `token` from contract address to `recipient`
     *
     * Useful if someone sent ERC20 tokens to the contract address by mistake.
     */
    function recoverERC20(
        address token,
        address recipient,
        uint256 amount
    ) external onlyOwner returns (bool) {
        require(token != address(this), "InpulseX: cannot recover IPX");
        return IERC20(token).transfer(recipient, amount);
    }
}
