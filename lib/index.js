import React, {Component} from "react";
import {requireNativeComponent, Dimensions} from 'react-native'

const RNQuickLookView = requireNativeComponent("QuickLookView");

const FileSource = {
	LOCAL: 0,
	DOWNLOAD: 1,
	MAIN: 2,
	BASE64: 3
};

class QuickLookView extends Component {

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
