// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title UddugToken
 * @author Pak Dias
 */
contract UddugToken is ERC20 {
    address public owner;

    /**
     * @dev Revert if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    /**
     * @dev Constructor to initialize the token with an initial supply and set the owner.
     * @param initialSupply The initial supply of the token.
     */
    constructor(uint256 initialSupply) ERC20("UddugToken", "UD") {
        _mint(msg.sender, initialSupply);
        owner = msg.sender;
    }

    /**
     * @dev Mint new tokens and assign them to the specified address.
     * Only the owner can call this function.
     * Emits a Mint event.
     * @param to The address to which the new tokens will be minted.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    /**
     * @dev Burn tokens from the specified address.
     * Only the owner can call this function.
     * Emits a Burn event.
     * @param from The address from which tokens will be burned.
     * @param amount The amount of tokens to burn.
     */
    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
        emit Burn(from, amount);
    }

    /**
     * @dev Overrides the ERC20 _transfer function to provide a public transfer function.
     * @param to The address to which tokens will be transferred.
     * @param value The amount of tokens to transfer.
     * @return A boolean indicating whether the transfer was successful.
     * @notice not neccessary, just wanted to make it explicit
     */
    function transfer(address to, uint256 value) public override returns (bool) {
        address sender = _msgSender();
        _transfer(sender, to, value);
        return true;
    }
}
