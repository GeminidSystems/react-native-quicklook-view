//
//  QuickLookViewManager.m
//  POCApp
//
//  Created by Geoffrey Xue on 7/22/20.
//

#import "ReactPOC-Bridging-Header.h"

@interface RCT_EXTERN_MODULE(QuickLookViewManager, RCTViewManager)
RCT_EXTERN_METHOD(generatePreview: (NSString *)src
                  fileType: (NSString *)fileType
                  fileID: (NSString *)fileID)

RCT_EXPORT_VIEW_PROPERTY(onFinishedLoading, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onTap, RCTDirectEventBlock)
RCT_REMAP_VIEW_PROPERTY(onHeld, onPress, RCTDirectEventBlock)
@end
