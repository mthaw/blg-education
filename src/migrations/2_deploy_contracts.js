const Token = artifacts.require("./Token.sol");
const KnowledgeCoin = artifacts.require("./KnowledgeCoin.sol");
const owner = web3.eth.accounts[0];

module.exports = deployer => {
  deployer.deploy(KnowledgeCoin, { from: owner });
  deployer.deploy(Token, { from: owner });
}