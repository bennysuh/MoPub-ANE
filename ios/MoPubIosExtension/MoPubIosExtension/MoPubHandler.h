//
//  MoPubHandler.h
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "MoPubBanner.h"

@interface MoPubHandler : NSObject
{
    
}

- (id)initWithContext:(FREContext)extensionContext;

- (FREObject) getDisplayDensity;
- (FREObject) setTestMode:(FREObject)asTesting;

- (FREObject) loadBannerWithAdUnitId:(FREObject)asAdUnitId size:(FREObject)asSize;
- (FREObject) showBanner:(FREObject)asKey;
- (FREObject) loadAndShowBannerWithAdUnitId:(FREObject)asAdUnitId size:(FREObject)asSize x:(FREObject)asX y:(FREObject)asY;;
- (FREObject) removeBanner:(FREObject)asKey;
- (FREObject) releaseBanner:(FREObject)asKey;
- (FREObject) removeAndReleaseBanner:(FREObject)asKey;

- (FREObject) setLocationX:(FREObject)asX y:(FREObject)asY onBanner:(FREObject)asKey;
- (FREObject) setIgnoresAutorefresh:(FREObject)asIgnoreRefresh onBanner:(FREObject)asKey;

@end
