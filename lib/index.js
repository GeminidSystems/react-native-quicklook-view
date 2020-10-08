import React, {Component} from "react";
import PropTypes from "prop-types";

import {requireNativeComponent, Dimensions} from 'react-native'

const RNQuickLookView = requireNativeComponent("QuickLookView");

const FileSource = {
	LOCAL: 0,
	DOWNLOAD: 1,
	MAIN: 2,
	BASE64: 3
};

class QuickLookView extends Component {

	static propTypes = {
		// Configurations for the size of the Quick Look Preview, RN attributes
		width: PropTypes.number,
		height: PropTypes.number,
		// Determines the properties used based on the source of your file
		fileSource: PropTypes.string,
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
		fileID: PropTypes.string
	};

	render() {

		const {
			style,
			width,
			height,
			fileSource,
			url,
			fileData,
			fileType,
			fileID
		} = this.props;

		return (
			<RNQuickLookView
				style = {style}
				width = {width || Dimensions.get('window').width}
				height = {height || Dimensions.get('window').height}
				fileSource = {FileSource[fileSource] || 0}
				url = {url}
				fileData = {fileData}
				fileType = {fileType}
				fileID = {fileID}
				ref = {ref => this.ref = ref}
			/>
		);
	}
}


export default QuickLookView;