import React from 'react';
import {
    View,
    Text,
    FlatList,
} from 'react-native';

import {styles} from './styles'

import ZoomView from './ZoomView'

export class Zoom {

  static screen({navigation}) {
      return (
            <View style = {styles.container}>
                <Text style = {styles.text}>
                    Hello, This is the zoom screen
                </Text>
                <ZoomView
                    style = {styles.quicklook}
                    width = {150}
                    height = {150}
                />
            </View>
        );
  }
}