//
//  QuickLookViewManager.m
//  POCApp
//
//  Created by Geoffrey Xue on 7/22/20.
//

#import "ReactPOC-Bridging-Header.h"

@interface RCT_EXTERN_MODULE(QuickLookViewManager, RCTViewManager)

RCT_REMAP_VIEW_PROPERTY(X, width, NSNumber)
RCT_REMAP_VIEW_PROPERTY(Y, height, NSNumber)
//RCT_EXPORT_VIEW_PROPERTY(width, NSNumber)
//RCT_EXPORT_VIEW_PROPERTY(height, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(urlString, NSString)
RCT_EXPORT_VIEW_PROPERTY(onUpdate, RCTDirectEventBlock)
@end
