react-native bundle --entry-file='index.js' --bundle-output='./ios/main.jsbundle' --dev=false --platform='ios'

#Generate Archive File
xcodebuild -workspace ios/ReactPOC.xcworkspace -scheme ReactPOC clean archive -configuration release -sdk iphoneos -archivePath dist/Archive.xcarchive -quiet

#Generate IPA w/
xcodebuild -exportArchive -archivePath  dist/Archive.xcarchive -exportOptionsPlist  exportOptions.plist -exportPath  dist -quiet