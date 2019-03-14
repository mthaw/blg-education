// Import the token build artifacts
const Token = artifacts.require("./Token.sol");

contract('Token.buy()', accounts => {
  // Define the owner account
  const owner = accounts[0];

  it("should buy new tokens.", async () => {
    // Create a new instance of the token, deployed from the owner
    const token = await Token.new({ from: owner });

    // Specify the wei value
    const value = 100;

    // Send the transaction to the token's buy method
    const txResponse = await token.buy({ from: owner, value });

    // Pull the rate from the contract to compute how may tokens should be bought and minted
    const rate = await token.rate();

    // Compute the token amount, wei * (token / wei)
    const tokenAmount = value * rate;

    // Event emission
    const event = txResponse.logs[0];

    // Assert correct values were emitted
    assert.equal(event.event, 'TokensMinted', 'TokensMinted event was not emitted.');
    assert.equal(event.args.to, owner, 'Incorrect to was emitted.');
    assert.equal(event.args.value, value, 'Incorrect value was emitted.');
    assert.equal(event.args.totalSupply.toNumber(), tokenAmount, 'Incorrect totalSupply was emitted.');

    // Balance
    const balance = await token.balanceOf(owner);
    assert.equal(balance.toNumber(), tokenAmount, 'Incorrect token balance.');

    // Total Supply
    const supply = await token.totalSupply();
    assert.equal(supply.toNumber(), tokenAmount, 'Incorrect total supply balance.');
  })

  /**
   * Add further test cases below
   */
});
