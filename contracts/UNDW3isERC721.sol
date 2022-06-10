//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title UNDW3isERC721
 * @dev Create by Discord Nekr#5112 for UNDW3 Lacoste art-contest because code is art !
 */

contract UNDW3isERC1155 is ERC1155, Ownable {

    using Strings for uint;

    uint public price = 0.08 ether;
    uint private constant max_supply = 11212;

    uint256 public constant Crocodile = 1;

    mapping (address => uint) public onlyOneNFTPerWallet;

    constructor() ERC1155("https://gateway.pinata.cloud/ipfs/QmRSdsJugGfd2WkGzwowcqtxgeeftmKL73yk5yx73c7jZX/{id}.json") {}

    function mint() external payable {
        require(msg.value >= price);
        require(totalSupply() < max_supply);
        require(onlyOneNFTPerWallet[msg.sender] == 0);
        onlyOneNFTPerWallet[msg.sender] += 1;
        _mint(msg.sender, Crocodile, 1, "");
    }

    function uri(uint256 _tokenId) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://gateway.pinata.cloud/ipfs/QmRSdsJugGfd2WkGzwowcqtxgeeftmKL73yk5yx73c7jZX/",
                Strings.toString(_tokenId),".json"
            )
        );
    }

}