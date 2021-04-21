const AccountMgmt = artifacts.require("./AccountMgmt.sol");

module.exports = function (deployer) {
  deployer.deploy(AccountMgmt);
};
