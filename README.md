### Prerequisites
* HardHat -> https://hardhat.org/tutorial

### Steps

1. Installing dependencies
 `npm install` 

2. Compiling smart contract
`npx hardhat compile`

3. Connect with remix

3.1. Installing dependencies

`npm install -g @remix-project/remixd`

3.2. Connect
<br>
`remixd -s <absolute-path-to-the-shared-folder> --remix-ide https://remix.ethereum.org`

4. Set `_initBaseURI`, use the following format

`ipfs://<YOUR_CID>/`