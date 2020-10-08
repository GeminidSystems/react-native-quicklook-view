//
//  QuickLookViewManager.m
//  POCApp
//
//  Created by Geoffrey Xue on 7/22/20.
//

#import "QuickLookView-Bridging-Header.h"

@interface RCT_EXTERN_MODULE(QuickLookViewManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(fileSource, NSNumber)
RCT_REMAP_VIEW_PROPERTY(url, urlString, NSString)
RCT_EXPORT_VIEW_PROPERTY(fileData, NSString)
RCT_EXPORT_VIEW_PROPERTY(fileType, NSString)
RCT_EXPORT_VIEW_PROPERTY(fileID, NSString)
@end
