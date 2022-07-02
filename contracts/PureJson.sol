// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';


contract PureJson is ERC721Enumerable
{
	struct Card {
		string beast;
		string action;
		string rare;
	}

	mapping(uint256 => Card) private tokenToCard;
	uint256 private tokenIdCounter;

	constructor() ERC721('PureJson', 'PJ') {}


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
		return string.concat(
			'data:application/json,{"name":"PureJson","description":"practicing to return a not encoded json string from the tokenURI method call","external_url":"https://austingriffith.com/portfolio/paintings/","image": "https://austingriffith.com/images/paintings/',
			card.beast,
			'.jpg","attributes":[{"trait_type":"Beast","value":"',
			card.beast,
			'"},{"trait_type":"Action","value":"',
			card.action,
			'"},{"trait_type":"Rare","value":"',
			card.rare,
			'"}]}'
		);
	}
}
