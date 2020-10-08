import React from 'react';
import { View } from 'react-native';

import QuickLookView from 'react-native-quicklook-view';

var example_file = {
    id: 1,
    fileSource: 'BASE64',
    fileData: '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',
    fileType: 'png'
};

var example_file_2 = {
    id: 2,
    fileSource: 'DOWNLOAD',
    url: 'https://www.weather.gov/media/wrn/MP4/2017DetermineYouRisk.mp4'
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
            fileSource = {example_file.fileSource}
            url = {example_file.url}
            fileData = {example_file.fileData}
            fileType = {example_file.fileType}
            fileID = {example_file.id}
          />
        </View>
    );
  }
}