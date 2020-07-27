import React, {Component} from 'react';
import {
    View,
    Text,
    FlatList
} from 'react-native';

import { styles, buttons } from './styles'  

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

export class QuickLook {
    static screen({navigation}) {
        return (
              <FlatList contentContainerStyle = {styles.list}
                data = {data}
                renderItem = {Item}
                keyExtractor = {item => item.id}
                ItemSeparatorComponent = {renderSeparator}
              />
          );
    }
}