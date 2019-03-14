import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter, Route} from "react-router-dom";
import StudentInfo from "./components/StudentInfo";
import Donation from "./components/Donation";

function MyApp(props) {
	return (
		<BrowserRouter>
			<div>
				<Route exact path="/" component={App}/>
				<Route exact path="/studentinfo" component={StudentInfo}/>
				<Route exact path="/donation" component={Donation}/>
			</div>
		</BrowserRouter>
		);
}

ReactDOM.render(<MyApp />, document.getElementById('root'));
registerServiceWorker();
