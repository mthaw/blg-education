import React from "react";
import {Link} from "react-router-dom";
import logo from './blg.jpg';
import DropDownMenu from 'material-ui/DropDownMenu';

export default function Donation(props) {
	return (
		<div>
		<div>
		<h3>Donate Ether</h3>
		</div>
		<h3>Student Accounts</h3>
      	<h3>Account Balance</h3>
      	<p className="App-intro">{this.state.ethBalance / 1e18} ETH</p>
		<div>
		<Link to="/">Return</Link>
		</div>
		</div>
		);
		
}