import React, {Component} from 'react';
import {
  View,
  Text,
  TouchableOpacity
} from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import { styles, buttons } from './styles'  

import {QuickLook} from './QuickLook'


const Stack = createStackNavigator();

function HomeScreen({navigation}) {
    return (
      <View style = {styles.container}>
        <TouchableOpacity
          style = {buttons.primary}
          onPress = {() => navigation.navigate('QuickLook')}
          underlayColor = '#fff'>
          <Text style = {buttons.primaryText}>Go to QuickLook</Text>
        </TouchableOpacity>
      </View>
    );
}

export default class App extends Component {
  render() {
    return (
        <NavigationContainer>
            <Stack.Navigator>
              <Stack.Screen name = "Home" component = {HomeScreen} />
              <Stack.Screen name = "QuickLook" component = {QuickLook.screen} />
              <Stack.Screen name = "QuickLookPreview" component = {QuickLook.previewScreen} />
            </Stack.Navigator>
        </NavigationContainer>
    );
  }

  updateNative = () => {
    console.log("update native")
    // Update QuickLookView
  }
}