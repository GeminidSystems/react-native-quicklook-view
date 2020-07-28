import React, {Component} from 'react';
import {
    View,
    Text,
    FlatList
} from 'react-native';

import { styles, buttons } from './styles'  

import QuickLookView, {FileType} from './QuickLookView'

const data = [
    {
        id: '0',
        url: 'test.jpeg',
        //fileType: FileType.MAIN,
        title: 'Test Picture'
    },
    {
        id: '1',
        url: 'example.pdf',
        //fileType: FileType.MAIN,
        title: 'Test PDF'
    },
    {
        id: '2',
        url: 'zoo.mp4',
        //fileType: FileType.MAIN,
        title: 'Zoo Video'
    },
    {
        id: '3',
        url: 'powerpoint.ppsx',
        //fileType: FileType.MAIN,
        title: 'Science Powerpoint'
    },
    {
        id: '4',
        url: 'broken link',
        //fileType: FileType.MAIN,
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
            //fileType = {item.fileType}
            thumbnail = {true}
            onTap = {() => console.log("Tapped")}
            onLongPress = {() => console.log("Long Pressed")}
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