// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./interfaces/IERC20.sol";

import "./libraries/Context.sol";
import "./libraries/Ownable.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Migrate is Context, Ownable {
    IERC20 private _token;
    address private _sender;
    mapping(address => bool) private _adminAddrs;

    constructor() {}

    /**
     * @dev Throws if called by any account other than the admins.
     */
    modifier onlyAdmins() {
        require(_adminAddrs[_msgSender()], "Caller is not an admin");
        _;
    }

    /**
     * @dev Set `addr` admin state to `state`.
     */
    function setIsAdmin(address addr, bool state) external onlyAdmins {
        _adminAddrs[addr] = state;
    }

    /**
     * @dev Check if `addr` is is an admin.
     */
    function setIsAdmin(address addr) external returns (bool) {
        return _adminAddrs[addr];
    }

    /**
     * @dev Sets the airdrop token address.
     */
    function setToken(address token) external onlyOwner {
        _token = IERC20(token);
    }

    /**
     * @dev Sets the airdrop token holder address. All tokens
     * will be sent from this address.
     */
    function setSender(address sender) external onlyOwner {
        _sender = sender;
    }

    /**
     * @dev Airdrop `amount` to `recipient`. Can be called by
     * admins only.
     */
    function airdrop(address recipient, uint256 amount) onlyAdmins {
        require(_token.transferFrom(_sender, recipient, amount));
    }

    /**
     * @dev Airdrop `amounts` to `recipients`. Can be called by
     * admins only.
     */
    function bulkAirdrop(
        address[] memory recipient,
        uint256[] memory amounts,
        uint256 length
    ) onlyAdmins {
        for (uint256 index = 0; index < length; index++) {
            airdrop(recipients[index], amounts[index]);
        }
    }
}
