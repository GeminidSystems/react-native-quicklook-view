//
//  QuickLookThumbnailManager.m
//  ReactPOC
//
//  Created by Geoffrey Xue on 7/27/20.
//

#import "ReactPOC-Bridging-Header.h"

@interface RCT_EXTERN_MODULE(QuickLookThumbnailManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(fileSource, NSNumber)
RCT_REMAP_VIEW_PROPERTY(url, urlString, NSString)
RCT_EXPORT_VIEW_PROPERTY(fileData, NSString)
RCT_EXPORT_VIEW_PROPERTY(fileType, NSString)
RCT_EXPORT_VIEW_PROPERTY(fileID, NSNumber)

RCT_EXPORT_VIEW_PROPERTY(onTap, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onLongPress, RCTDirectEventBlock)
@end
