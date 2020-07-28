//QuickLookView.js

import React, {Component} from "react";
import PropTypes from "prop-types";

import {requireNativeComponent} from 'react-native'

const RNQuickLookView = requireNativeComponent("QuickLookView");
const RNQuickLookThumbnail = requireNativeComponent("QuickLookThumbnail");

export const FileType = {
	LOCAL: 0,
	ONLINE_URL: 1,
	MAIN: 2,
	ENCODED_STRING: 3
};

export default class QuickLookView extends Component {
	
	static propTypes = {
		width: PropTypes.number,
		height: PropTypes.number,

		url: PropTypes.string,
		fileType: PropTypes.number,

		thumbnail: PropTypes.bool,
		onTap: PropTypes.func,
		onLongPress: PropTypes.func
	};
	
	handleChange = () => {
		var self = this;          // Store `this` component outside the callback
		if ('onorientationchange' in window)
			window.addEventListener("orientationchange", function() {
				console.log("onorientationchange");
			}, false);
	}

	render() {
		const {style, width, height, url, fileType, thumbnail, onTap, onLongPress} = this.props;
		if (height == null)
			height = Dimensions.get('window').height;

		if (thumbnail)
			return (
				<RNQuickLookThumbnail
					style = {style}
					componentDidMount = {this.handleChange}
					width = {width}
					height = {height}
					test = {"test"}
					urlString = {url}
					//fileType = {fileType}

					onTap = {event => {if (onTap) {onTap(event)}}}
					onLongPress = {event => {if (onLongPress) {onLongPress(event)}}}
					ref = {ref => this.ref = ref}
				/>
			);
		else
			return (
				<RNQuickLookView
					style = {style}
					componentDidMount = {this.handleChange}
					width = {width}
					height = {height}
					urlString = {url}
					//fileType = {fileType}
					ref = {ref => this.ref = ref}
				/>
			);
	}
}