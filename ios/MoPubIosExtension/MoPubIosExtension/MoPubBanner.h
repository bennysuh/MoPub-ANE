//
//  MoPubBanner.h
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "MPAdView.h"

@interface MoPubBanner : MPAdView <MPAdViewDelegate>
{
}

+ (CGSize) getAdSizeFromSizeId:(int) sizeId;

- (id) initWithContext:( FREContext ) extensionContext adUnitId:(NSString*)adUnitId size:(CGSize)size;

- (void) setPositionX:(double)value;
- (void) setPositionY:(double)value;

- (double) getCreativeWidth;
- (double) getCreativeHeight;

- (void) loadBanner;
- (void) showBanner;
- (void) removeBanner;

@end
