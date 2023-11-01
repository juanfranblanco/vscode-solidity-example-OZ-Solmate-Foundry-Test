## Vscode Solidity Example using Foundry / Forge tests with Open Zeppelin and Solmate.

This project provides an example of an environment / configuration to work with Foundry and the Visual Studio Code Solidity extension.

It is assumed that you have already installed foundry and initialise the project as per the first steps: https://book.getfoundry.sh/getting-started/first-steps ```forge init hello_foundry```.

## Downloading and running this Example.
+ Install foundry to run tests
+ git clone (this repo)
+ forge update (to update repos)
  
## Vscode solidity configuration
The project has been configured using a specfic version of solidty and contracts directory (more on this to follow), you can simply change the solidity version by right clicking on a solidity file and change the remote version, this defaults to the latest.
```json
{
    "solidity.compileUsingRemoteVersion": "v0.8.20+commit.a1b79de6",
    "solidity.packageDefaultDependenciesContractsDirectory": "['src', '', 'contracts']"
}
```
Vscode solidity defaults to mono-repo support, allowing to work with different projects at the same time.

The file can be found here: https://github.com/juanfranblanco/vscode-solidity-example-OZ-Solmate-Foundry-Test/blob/master/.vscode/settings.json

## Adding Open Zeppelin
To add open zeppelin, in this example it has been added using the "git" version. 

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

Then the remappings.txt file has been configured to add the mapping as follows:
```
@openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/
```

The file can be found here https://github.com/juanfranblanco/vscode-solidity-example-OZ-Solmate-Foundry-Test/blob/master/remappings.txt

This enables to resolve the following paths for OpenZeppelin:

```solidity
// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Votes.sol";

contract OZErc721 is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Pausable, Ownable, ERC721Burnable, EIP712, ERC721Votes {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("MyErc721", "MTK")
        Ownable(initialOwner)
        EIP712("MyErc721", "1")
    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

```


## Adding Solmate
To add solmate just install it the same way as open zeppelin, this example follows some of the examples included here https://book.getfoundry.sh/tutorials/solmate-nft

```bash
forge install transmissions11/solmate
```

Foundry contract path resolution is the same as the old Dapple so paths can be resolved using the the library name and the contract folders, for example:

```import "solmate/tokens/ERC721.sol"; ```

corresponds to :

```import "lib/solmate/src/tokens/ERC721.sol"; ```

"lib" and "node_modules" are already a default path in vscode-solidity, so these are resolved automatically, but to resolve ```src``` as a subfolder contracts path we add the following setting:

```
 "solidity.packageDefaultDependenciesContractsDirectory": "['src', '', 'contracts']"
```

I have included here not just 'src' but other folders so they can be resolved like none '' and 'contracts' that are also common.


The following contract can resolve the paths now for solmate ```import "solmate/tokens/ERC721.sol";```
and for Open Zeppelin (different from the one before in remappings) as it uses the path "openzeppelin-contracts/contracts", that corresponds to "lib/openzeppelin-contracts/contracts/" automatically resolved both by Foundry and vscode-solidty.

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "solmate/tokens/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract SolErc721 is ERC721 {
    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function mintTo(address recipient) public payable returns (uint256) {
        uint256 newItemId = ++currentTokenId;
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        return Strings.toString(id);
    }
}
```


