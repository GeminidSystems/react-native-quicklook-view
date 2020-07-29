//QuickLookView.js

import React, {Component} from "react";
import PropTypes from "prop-types";

import {requireNativeComponent} from 'react-native'

const RNQuickLookView = requireNativeComponent("QuickLookView");
const RNQuickLookThumbnail = requireNativeComponent("QuickLookThumbnail");

export const FileSource = {
	// Attempts to retrieve from documents directory of file manager
	LOCAL: 0,
	// Downloads file and overrides any file with the same id and file extension
	DOWNLOADABLE: 1,
	MAIN: 2,
	BASE64: 3
};

export const FileType = {
	PNG: "png",
	JPEG: "jpeg",
	PDF: "pdf"
	// Add more as I go
}

export default class QuickLookView extends Component {
	
	static propTypes = {
		// Configurations for the size of the Quick Look Preview, RN attributes
		width: PropTypes.number,
		height: PropTypes.number,

		// Determines the properties used based on the source of your file
		fileSource: PropTypes.number,
		// For local, main, downloadable files
		// Local files are already downloaded files located in the FileManager Documents Directory
		// Main files are files located in the XCodeProject for testing
		url: PropTypes.string,
		// For base64 files
		fileData: PropTypes.string,
		// Differentiates the type of base64 file
		fileType: PropTypes.string,
		// For local, downloadable, and base64 files
		// fileID must be unique
		// Used in place of the url name in conjunction with the file extention. Ex: 1085.png
		fileID: PropTypes.number,


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
		const {	style, width, height, 
				fileSource, url, fileData, fileType, fileID,
				thumbnail, onTap, onLongPress
			} = this.props;
		if (height == null)
			height = Dimensions.get('window').height;

		console.log(fileSource)

		if (thumbnail)
			return (
				<RNQuickLookThumbnail
					style = {style}
					componentDidMount = {this.handleChange}
					width = {width}
					height = {height}
					
					fileSource = {fileSource}
					url = {url}
					fileData = {fileData}
					fileType = {fileType}
					fileID = {fileID}

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
					url = {url}
					ref = {ref => this.ref = ref}
				/>
			);
	}
}