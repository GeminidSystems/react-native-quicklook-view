# QuickLook View
#### react-native-quicklook-view

Quicklook View is a React Native module that allows you to preview images, documents, and other files through BASE64 and URLs.

### Installation
Install the module through npm:
```
npm install react-native-quicklook-view
```
Update dependencies for IOS:
```
cd ios
pod install
```

### Example App
Here's an example app that you can paste into App.js. This will display a simple Apple JPG image with a couple of event handlers.
```
import React from 'react';
import { View } from 'react-native';

import QuickLookView from 'react-native-quicklook-view';

var example_file = {
        id: "5",
        src: 'https://image.shutterstock.com/image-photo/red-apple-isolated-on-white-260nw-1498042211.jpg',
        title: 'Apple Picture'
};

export default class QuickLookViewExample extends React.Component {

  render() {
    return (
      <View>
        <QuickLookView
            style = {{
              alignItems: "center",
              justifyContent: "center",
            }}
            src = {example_file.src}
            fileType = {example_file.fileType}
            fileID = {example_file.id}
            onTap = {() => console.log("Tapped")}
            onHeld = {() => console.log("Held")}
          />
      </View>
    );
  }
}
```
