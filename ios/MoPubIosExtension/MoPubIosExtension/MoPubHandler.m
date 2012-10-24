//
//  MoPubHandler.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import "MoPubHandler.h"
#import "MoPub_TypeConversion.h"
#import "MoPubBanner.h"

@interface MoPubHandler () {
}
@property FREContext context;
@property (nonatomic, retain)NSMutableDictionary* banners;
@property (nonatomic, retain)MoPub_TypeConversion* converter;
@property (nonatomic, assign) BOOL testing;

@end

@implementation MoPubHandler

@synthesize context, banners, converter;

- (id)initWithContext:(FREContext)extensionContext
{
    self = [super init];
    if( self )
    {
        context = extensionContext;
        banners = [[NSMutableDictionary alloc] init];
        converter = [[MoPub_TypeConversion alloc] init];
    }
    return self;
}

- (NSString*) storeBanner:(MoPubBanner*)banner
{
    NSString* key;
    do
    {
        key = [NSString stringWithFormat: @"%li", random()];
    } while ( [self.banners valueForKey:key] != nil );
    [self.banners setValue:banner forKey:key];
    banner.key = key;
    return key;
}

- (MoPubBanner*) getBannerWithKey:(NSString*) key
{
    MoPubBanner* banner = [self.banners valueForKey:key];
    return banner;
}

- (void) deleteBannerWithKey:(NSString*) key
{
    [banners setValue:nil forKey:key];
}

- (CGSize) getAdSizeFromSizeId:(int) sizeId
{
    switch( sizeId )
    {
        case 1:
            return MOPUB_BANNER_SIZE;
        case 2:
            return MOPUB_MEDIUM_RECT_SIZE;
        case 3:
            return MOPUB_LEADERBOARD_SIZE;
        case 4:
            return MOPUB_WIDE_SKYSCRAPER_SIZE;
        default:
            return MOPUB_BANNER_SIZE;
    }
}

- (FREObject) getDisplayDensity
{
    double density = [UIScreen mainScreen].scale;
    FREObject asDensity;
    if( [converter FREGetDouble:density asObject:&asDensity] )
    {
        return asDensity;
    }
    return NULL;
}

- (FREObject) setTestMode:(FREObject)asTesting
{
    uint32_t test;
    if( [self.converter FREGetObject:asTesting asBoolean:&test] != FRE_OK ) return NULL;
    self.testing = ( test == 1 );
    return NULL;
}

- (FREObject) loadBannerWithAdUnitId:(FREObject)asAdUnitId size:(FREObject)asSize;
{
    NSString* adUnitId;
    if( [self.converter FREGetObject:asAdUnitId asString:&adUnitId] != FRE_OK ) return NULL;
    
    int adSizeId;
    if( [self.converter FREGetObject:asSize asInt:&adSizeId] != FRE_OK ) return NULL;
    CGSize adSize = [self getAdSizeFromSizeId:adSizeId];
    
    MoPubBanner* banner = [[MoPubBanner alloc] initWithContext:context adUnitId:adUnitId size:adSize];
    banner.testing = self.testing;
    [banner loadAd];
    
    NSString* code = [self storeBanner:banner];
    FREObject asCode;
    if( [self.converter FREGetString:code asObject:&asCode] == FRE_OK )
    {
        return asCode;
    }
    return NULL;
}

- (FREObject) showBanner:(FREObject)asKey
{
    NSString* key;
    if( [self.converter FREGetObject:asKey asString:&key] != FRE_OK ) return NULL;
    
    MoPubBanner* banner = [self getBannerWithKey:key];
    if( banner != nil )
    {
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:banner];
    }
    
    return NULL;
}

- (FREObject) loadAndShowBannerWithAdUnitId:(FREObject)asAdUnitId size:(FREObject)asSize x:(FREObject)asX y:(FREObject)asY;
{
    NSString* adUnitId;
    if( [self.converter FREGetObject:asAdUnitId asString:&adUnitId] != FRE_OK ) return NULL;
    
    int adSizeId;
    if( [self.converter FREGetObject:asSize asInt:&adSizeId] != FRE_OK ) return NULL;
    CGSize adSize = [self getAdSizeFromSizeId:adSizeId];
    
    double x;
    if( [self.converter FREGetObject:asX asDouble:&x] != FRE_OK ) return NULL;
    
    double y;
    if( [self.converter FREGetObject:asY asDouble:&y] != FRE_OK ) return NULL;
    
    MoPubBanner* banner = [[MoPubBanner alloc] initWithContext:context adUnitId:adUnitId size:adSize];
    banner.testing = self.testing;
    [banner loadAd];
    [banner setOriginX:x y:y];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:banner];
    
    NSString* code = [self storeBanner:banner];
    FREObject asCode;
    if( [self.converter FREGetString:code asObject:&asCode] == FRE_OK )
    {
        return asCode;
    }
    return NULL;
}

- (FREObject) removeBanner:(FREObject)asKey
{
    NSString* key;
    if( [self.converter FREGetObject:asKey asString:&key] != FRE_OK ) return NULL;
    
    MoPubBanner* banner = [self getBannerWithKey:key];
    if( banner != nil )
    {
        [banner removeFromSuperview];
    }
    
    return NULL;
}

- (FREObject) releaseBanner:(FREObject)asKey
{
    NSString* key;
    if( [self.converter FREGetObject:asKey asString:&key] != FRE_OK ) return NULL;
    
    MoPubBanner* banner = [self getBannerWithKey:key];
    if( banner != nil )
    {
        [banner release];
        [self deleteBannerWithKey:key];
    }
    
    return NULL;
}

- (FREObject) removeAndReleaseBanner:(FREObject)asKey
{
    NSString* key;
    if( [self.converter FREGetObject:asKey asString:&key] != FRE_OK ) return NULL;

    MoPubBanner* banner = [self getBannerWithKey:key];
    if( banner != nil )
    {
        [banner removeFromSuperview];
        [banner release];
        [self deleteBannerWithKey:key];
    }
    
    return NULL;
}

- (FREObject) setLocationX:(FREObject)asX y:(FREObject)asY onBanner:(FREObject)asKey
{
    NSString* key;
    if( [self.converter FREGetObject:asKey asString:&key] != FRE_OK ) return NULL;
    
    MoPubBanner* banner = [self getBannerWithKey:key];
    if( banner != nil )
    {
        double x;
        if( [self.converter FREGetObject:asX asDouble:&x] != FRE_OK ) return NULL;
        
        double y;
        if( [self.converter FREGetObject:asY asDouble:&y] != FRE_OK ) return NULL;
        
        [banner setOriginX:x y:y];
    }
    
    return NULL;
}

- (FREObject) setIgnoresAutorefresh:(FREObject)asIgnoreRefresh onBanner:(FREObject)asKey
{
    NSString* key;
    if( [self.converter FREGetObject:asKey asString:&key] != FRE_OK ) return NULL;
    MoPubBanner* banner = [self getBannerWithKey:key];
    
    if( banner != nil )
    {
        uint32_t ignoreRefresh;
        if( [self.converter FREGetObject:asIgnoreRefresh asBoolean:&ignoreRefresh] != FRE_OK ) return NULL;
        banner.ignoresAutorefresh = ( ignoreRefresh == 1 );
    }
    return NULL;
}


@end
