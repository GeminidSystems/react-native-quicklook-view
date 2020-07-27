//QuickLook.js

import React, {Component} from "react";
import PropTypes from "prop-types";

import {
	requireNativeComponent,
	UIManager
} from 'react-native'

const COMPONENT_NAME = "QuickLookView";
const RNQuickLookView = requireNativeComponent(COMPONENT_NAME);

export default class QuickLook extends Component {
	
	static propTypes = {
		width: PropTypes.number,
		height: PropTypes.number,
		url: PropTypes.string
	};
	
	handleChange = () => {
		var self = this;          // Store `this` component outside the callback
		if ('onorientationchange' in window) {
			window.addEventListener("orientationchange", function() {
				console.log("onorientationchange");
			}, false);
		}
	}

	_onUpdate = event => {
		if (this.props.onUpdate) {
		  	this.props.onUpdate(event.nativeEvent);
		}
		console.log("test")
		console.log(event)
	};

	render() {
		const {style, width, height, url} = this.props;
		if (height == null) {
			height = Dimensions.get('window').height;
		}
		return (
			<RNQuickLookView
				style = {style}
				componentDidMount = {this.handleChange}
				width = {width}
            	height = {height}
				urlString = {url}
				onUpdate = {this._onUpdate}
				ref = {ref => this.ref = ref}
			/>
		);
	}
}