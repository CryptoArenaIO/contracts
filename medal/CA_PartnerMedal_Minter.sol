// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC721 {
    function safeMint(address to) external returns (uint256); 
    function balanceOf(address owner) external view returns (uint256);
}

contract CA_Parter_Minter is AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    address public constant MEDALNFT = 0xa4E3e1F00F5d30943638A502C544974a66256927;
    uint256 public constant LIMIT_COUNT = 10000;
    uint256 public current_minted = 0;

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to) public onlyRole(MINTER_ROLE) {
        if (current_minted < LIMIT_COUNT) {
            IERC721(MEDALNFT).safeMint(to);
            current_minted += 1;
        }
    } 
}
