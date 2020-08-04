//ZoomView.js

import React, {Component} from "react";
import PropTypes from "prop-types";

import {
    requireNativeComponent, 
    View, 
    TouchableOpacity, 
    Text,
    UIManager,
    findNodeHandle} from 'react-native'
import { styles, buttons } from "./styles";

const RNZoomView = requireNativeComponent("ZoomView");

export default class ZoomView extends Component {
	
	static propTypes = {
		// Configurations for the size of the Quick Look Preview, RN attributes
		width: PropTypes.number,
		height: PropTypes.number,
    };
    
    onButtonClick(e) {
        console.log(this.ref);
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this.ref),
            UIManager.RNZoomView.Commands.startMeetingViaManager,
            []
          );
    }
	
	render() {
		const {	style, width, height} = this.props;

		return (
            <View style = {styles.container}>
                <TouchableOpacity
                    style = {buttons.primary}
                    onPress = {this.onButtonClick}
                    underlayColor = '#fff'>
                    <Text style = {buttons.primaryText}>Start Meeting</Text>
                </TouchableOpacity>
                <RNZoomView
                    style = {style}
                    width = {width}
                    height = {height}
                    
                    ref = {ref => this.ref = ref}
                />
            </View>

		);
	}
}