import React from 'react';
import {
    View,
    Text,
    FlatList,
    Dimensions
} from 'react-native';

import {styles} from './styles'  

import {data} from './Data'

import QuickLookView from './QuickLookView'

const renderSeparator = () => {return (<View style = {styles.separator}/>); };  

export class QuickLook {

  static previewTitle = "Example"

  static onPressText(item, navigation) {
    console.log(item);
    navigation.navigate("QuickLookPreview", {
      id: item.id,
      fileSource: item.fileSource,
      url: item.url,
      fileData: item.fileData,
      fileType: item.fileType,
      title: item.title
    })
  }

  static screen({navigation}) {
      return (
            <FlatList contentContainerStyle = {styles.list}
              data = {data}
              renderItem = {({item}) => (
                <View style = {styles.item}>
                  <Text style = {styles.text} onPress = {() => QuickLook.onPressText(item, navigation)}>{item.title}</Text>
                </View>
              )}
              keyExtractor = {item => item.id}
              ItemSeparatorComponent = {renderSeparator}
            />
        );
  }

  static previewScreen({route, navigation}) {
    const {id, fileSource, url, fileData, fileType, title} = route.params;
    return (
      <View style = {styles.container}>
        <QuickLookView
          style = {styles.quicklook}
          height = {Dimensions.get('window').height}
          fileSource = {fileSource}
          url = {url}
          fileData = {fileData}
          fileType = {fileType}
          fileID = {parseInt(id, 10)}
          onTap = {() => console.log("Tapped")}
          onLongPress = {() => console.log("Long Pressed")}
        />
      </View>
    );
  }
}