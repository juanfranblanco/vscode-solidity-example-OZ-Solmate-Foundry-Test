## Vscode Solidity Example using Foundry / Forge tests with Open Zeppelin and Solmate.

This project provides an example of an environment / configuration to work with Foundry and the Visual Studio Code Solidity extension.

It is assumed that you have already installed foundry and initialise the project as per the first steps: https://book.getfoundry.sh/getting-started/first-steps ```forge init hello_foundry```.

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


