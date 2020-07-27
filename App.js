import React, {Component} from 'react';
import {
  StyleSheet,
  View,
  Text,
  FlatList
} from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import QuickLookView from './QuickLookView'

const data = [
  {
    id: '0',
    url: 'test.jpeg',
    title: 'Test Picture'
  },
  {
    id: '1',
    url: 'example.pdf',
    title: 'Test PDF'
  },
  {
    id: '2',
    url: 'zoo.mp4',
    title: 'Zoo Video'
  },
  {
    id: '3',
    url: 'powerpoint.ppsx',
    title: 'Science Powerpoint'
  },
  {
    id: '4',
    url: 'broken link',
    title: 'Broken Link'
  }
]


const Stack = createStackNavigator();

const Item = ({item}) => (
  <View style = {styles.item}>
    <Text style = {styles.text}>{item.title}</Text>
    <QuickLookView
          style = {styles.quicklook}
          height = {300}
          url = {item.url}
    />
  </View>
);

const renderSeparator = () => {return (<View style = {styles.separator}/>); };  


function HomeScreen() {
    return (
      <FlatList contentContainerStyle = {styles.list}
        data = {data}
        renderItem = {Item}
        keyExtractor = {item => item.id}
        ItemSeparatorComponent = {renderSeparator}
      />
    );
}

export default class App extends Component {
  render() {
    return (
        <NavigationContainer>
            <Stack.Navigator>
              <Stack.Screen name = "Home" component = {HomeScreen} />
            </Stack.Navigator>
        </NavigationContainer>
    );
  }

  updateNative = () => {
    console.log("update native")
    // Update QuickLookView
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    alignItems: "stretch"
  },
  list: {
    alignItems: "stretch"
  },
  quicklook: {
    alignItems: "center",
    justifyContent: "center",
  },
  text: { 
    textAlign: 'center',
    fontSize: 14,
    marginVertical: 4
  },
  item: {
    justifyContent: "center",
    backgroundColor: '#FFFFFF',
    padding: 5,
    marginVertical: 8,
    marginHorizontal: 16,
  },
  separator: {
    height: 1,  
    width: "100%",  
    backgroundColor: "#999999",  
  },
  border: {
    borderColor: "#eee", borderBottomWidth: 1
  },
});