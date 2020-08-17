import React, {Component} from "react";
import PropTypes from "prop-types";

import {requireNativeComponent, NativeModules, ActivityIndicator, View} from 'react-native'

const RNQuickLookView = requireNativeComponent("QuickLookView");

export const FileType = {
	PNG: "png",
	JPG: "jpg",
	JPEG: "jpeg",
	PDF: "pdf",
	MP4: "mp4",
	PPSX: "ppsx"
	// Add more as I go
}

const styles = {
	loading: {
		position: 'absolute',
		left: 0,
		right: 0,
		top: 0,
		bottom: 0,
		alignItems: 'center',
		justifyContent: 'center'
	},
	container: {
		flex: 1, 
		flexDirection: "column"
	},
	hidden: {
		display: 'none'
	}
}

class QuickLookView extends Component {

	constructor(props) {
		super(props);
		this.state = {
			loading: true
		}
    }
	
	static propTypes = {
		// Configurations for the size of the Quick Look Preview, RN attributes
		width: PropTypes.number,
		height: PropTypes.number,

		src: PropTypes.string,
		// Differentiates the type of base64 file
		fileType: PropTypes.string,
		fileID: PropTypes.string,


		onTap: PropTypes.func,
		onHeld: PropTypes.func
	};

	componentDidMount() {
		let {src, fileType, fileID} = this.props;
        setTimeout(function() {
			if (fileType == null) {
				fileType = FileType.PNG;
			}
			NativeModules.QuickLookViewManager.generatePreview(src, fileType, fileID);
        }, 100);
    }

	renderLoadingScreen() {
		if (this.state.loading) {
			return (
				<ActivityIndicator style = {styles.loading}/>
			)
		}
	}

	render() {
		const {	style, width, height, 
			onTap, onHeld
		} = this.props;

		return (
			<View style = {styles.container} >			
				<RNQuickLookView
					style = {!this.state.loading ? style : styles.hidden}
					width = {width || Dimensions.get('window').width}
					height = {height || Dimensions.get('window').height}

					onTap = {onTap}
					onHeld = {onHeld}
					onFinishedLoading = {() => {
						console.log("finished Loading")
						this.setState({loading: false})
					}}
					
					ref = {ref => this.ref = ref}
				/>
				{this.renderLoadingScreen()}
			</View>
		);
	}
}


export default QuickLookView;