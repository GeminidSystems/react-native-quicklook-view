import React, {Component} from 'react';
import {
    View,
    Text,
    FlatList
} from 'react-native';

import { styles, buttons } from './styles'  

import {data} from './Data'

import QuickLookView, {FileType, FileSource} from './QuickLookView'

/*
        fileSource: FileSource.MAIN,
        url: 'test.jpeg',
        fileData:
        fileType:*/

const Item = ({item}) => (
    <View style = {styles.item}>
      <Text style = {styles.text}>{item.title}</Text>
      <QuickLookView
            style = {styles.quicklook}
            height = {300}
            fileSource = {item.fileSource}
            url = {item.url}
            fileData = {item.fileData}
            fileType = {item.fileType}
            fileID = {parseInt(item.id, 10)}
            thumbnail = {item.thumbnail}
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