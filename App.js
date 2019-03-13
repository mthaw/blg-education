import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import logo from './blg.jpg';
import './App.css';
// Import the web3 library
import Web3 from 'web3';

// Material UI
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import DropDownMenu from 'material-ui/DropDownMenu';
import RaisedButton from 'material-ui/RaisedButton';
import TextField from 'material-ui/TextField';
import MenuItem from 'material-ui/MenuItem';

// Import build Artifacts
import tokenArtifacts from './build/contracts/Token.json';

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      amount: 0,
      availableAccounts: [],
      defaultAccount: 0,
      ethBalance: 0,
      rate: 1,
      tokenBalance: 0,
      tokenSymbol: 'CCO',
      transferAmount: '',
      transferUser: '',
      token: null, // token contract
    };
  }

  async componentDidMount() {
    // Create a web3 connection
    this.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:9545"));

    this.web3.version.getNetwork(async (err, netId) => {
      const tokenAddress = tokenArtifacts.networks[netId].address;
      const token = this.web3.eth.contract(tokenArtifacts.abi).at(tokenAddress);
      this.setState({ token });
      console.log(token);
      
      this.loadAccountBalances(this.web3.eth.accounts[0]);
      this.loadEventListeners();

      this.web3.eth.getAccounts(async (err, accounts) => {
        // Append all available accounts
        for (let i = 0; i < accounts.length; i++) {
          console.log(await token.fundAccount(accounts[i], 100, { from: accounts[i] }));

          this.setState({
            availableAccounts: this.state.availableAccounts.concat(
              <MenuItem value={i} key={accounts[i]} primaryText={accounts[i]} />
            )
          });
        }
      });
    });
  }

  // Load the accounts token and ether balances.
  async loadAccountBalances(account) {
    const balance = await this.state.token.balanceOf(account);
    this.setState({ tokenBalance: balance.toNumber() });

    const ethBalance = await this.web3.eth.getBalance(account);
    this.setState({ ethBalance: ethBalance });
  }

  // Create listeners for all events.
  loadEventListeners() {
    this.state.token.Transfer().watch((err, res) => {
      console.log(`Tokens Transferred! TxHash: ${res.transactionHash} \n ${JSON.stringify(res.args)}`);
      this.loadAccountBalances(this.web3.eth.accounts[this.state.defaultAccount]);
    });

    this.state.token.Erase().watch((err, res) => {
      console.log(`Tokens Erased! TxHash: ${res.transactionHash} \n ${JSON.stringify(res.args)}`);
      this.loadAccountBalances(this.web3.eth.accounts[this.state.defaultAccount]);
    });
  }

  // Buy new tokens with eth
  async claim(amount) {
    const sender = this.web3.eth.accounts[this.state.defaultAccount];
    const transactionHash = await this.state.token.transfer(amount, { from: sender });
    console.log(transactionHash);
  }

  // Transfer tokens to a user
  async transfer(user, amount) {
    const sender  = this.web3.eth.accounts[this.state.defaultAccount];
    const transactionHash = await this.state.token.transfer(user, amount, { from: sender });
    console.log(transactionHash);
  }

  // When a new account in selected in the available accounts drop down.
  handleDropDownChange = (event, index, defaultAccount) => {
    this.setState({ defaultAccount });
    this.loadAccountBalances(this.state.availableAccounts[index].key);
  }

  render() {
    let component;

    component = <div>
      <br />
      <h3>Student Accounts</h3>
      <DropDownMenu maxHeight={300} width={500} value={this.state.defaultAccount} onChange={this.handleDropDownChange}>
        {this.state.availableAccounts}
      </DropDownMenu>

      <h3>Account Balance</h3>
      <p className="App-intro">{this.state.ethBalance / 1e18} ETH</p>
      <p className="App-intro"> {this.state.tokenBalance} {this.state.tokenSymbol}</p>
      <br />
      <div>
        <h3>Claim Token Value</h3>
        <TextField floatingLabelText="Token Amount" style={{width: 200}} value={this.state.amount}
          onChange={(e, amount) => {this.setState({ amount })}}
        />
        <RaisedButton label="CLAIM" labelPosition="before"
          onClick={() => this.claim(this.state.amount)}
        />
      </div>
      <br />
      {/* ADD THE TRANSFER TOKENS FORM BENEATH HERE */}
     
    </div>

    return (
      <MuiThemeProvider>
        <div className="App">
          <header className="App-header">
            <img src={logo} alt="logo" style={{height: '150px', width: '350px'}}/>
          </header>
          <BrowserRouter>
            <div>
              <Route exact={true} path="/" render={() => component}/>
            </div>
          </BrowserRouter>
        </div>
      </MuiThemeProvider>
    );
  }
}

export default App;
