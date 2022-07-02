// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import './ImageStorage.sol';
import 'base64-sol/base64.sol';


contract Base64JsonWithEncodedImage is ERC721Enumerable, ImageStorage
{
	struct Card {
		string beast;
		string action;
		string rare;
	}

	mapping(uint256 => Card) private tokenToCard;
	uint256 private tokenIdCounter;

	constructor() ERC721('Base64Json', 'BJ') {}


	function mint(string calldata _beast, string calldata _action, string calldata _rare) external {
		Card memory card = Card(_beast, _action, _rare);
		unchecked {
			tokenIdCounter += 1;
		}
		uint256 tokenId = tokenIdCounter;
		tokenToCard[tokenId] = card;
		_safeMint(msg.sender, tokenId);
	}

	function tokenURI(uint256 tokenId) public view override returns(string memory) {
		_requireMinted(tokenId);

		Card memory card = tokenToCard[tokenId];
		string memory json = string.concat(
			'data:application/json,{"name":"PureJson","description":"practicing to return a not encoded json string from the tokenURI method call","external_url":"https://austingriffith.com/portfolio/paintings/","image":"',
			store[card.beast],
			'","attributes":[{"trait_type":"Beast","value":"',
			card.beast,
			'"},{"trait_type":"Action","value":"',
			card.action,
			'"},{"trait_type":"Rare","value":"',
			card.rare,
			'"}]}'
		);

		return string.concat(
			'data:application/json;base64,',
			Base64.encode(
				bytes(json)
			)
		);
	}
}
