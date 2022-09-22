/* SPDX-License-Identifier: BUSL-1.1 */
/* Copyright © 2021 Fragcolor Pte. Ltd. */

pragma solidity ^0.8.7;

abstract contract Ownable {
    address public constant DEFAULT_PROTOCOL_OWNER =
        0x0123456789012345678901234567890123456789;

    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        _bootstrap(DEFAULT_PROTOCOL_OWNER);
    }

    function _bootstrap() internal {
        _owner = DEFAULT_PROTOCOL_OWNER;
        emit OwnershipTransferred(address(0), DEFAULT_PROTOCOL_OWNER);
    }

    function _bootstrap(address initialOwner) internal {
        _owner = initialOwner;
        emit OwnershipTransferred(address(0), initialOwner);
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
