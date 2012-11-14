//
//  MoPubIosExtension.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "MoPubTypeConversion.h"
#import "MoPubBanner.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

MoPub_TypeConversion* converter;

DEFINE_ANE_FUNCTION( initialiseBanner )
{
    NSString* adUnitId;
    if( [converter FREGetObject:argv[0] asString:&adUnitId] != FRE_OK ) return NULL;
    
    CGSize adType;
    int32_t sizeId;
    if( [converter FREGetObject:argv[1] asInt:&sizeId] == FRE_OK )
    {
        adType = [MoPubBanner getAdSizeFromSizeId:sizeId];
    }
    else
    {
        adType = MOPUB_BANNER_SIZE;
    }
    
    MoPubBanner* banner = [[MoPubBanner alloc] initWithContext:context adUnitId:adUnitId size:adType];
    [banner retain];
    FRESetContextNativeData( context, banner );
    return NULL;
}

DEFINE_ANE_FUNCTION( setAutorefresh )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        uint32_t autoRefresh;
        if( [converter FREGetObject:argv[0] asBoolean:&autoRefresh] != FRE_OK ) return NULL;
        [banner setAutorefresh:( autoRefresh == 1 )];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setTestMode )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        uint32_t testing;
        if( [converter FREGetObject:argv[0] asBoolean:&testing] != FRE_OK ) return NULL;
        banner.testing = ( testing == 1 );
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setAdUnitId )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        NSString* adUnitId;
        if( [converter FREGetObject:argv[0] asString:&adUnitId] != FRE_OK ) return NULL;
        [banner setAdUnitId:adUnitId];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( lockNativeAdsToOrientation )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t orientation;
        if( [converter FREGetObject:argv[0] asInt:&orientation] != FRE_OK ) return NULL;
        switch( orientation )
        {
            case 0:
                [banner lockNativeAdsToOrientation:MPNativeAdOrientationAny];
                break;
            case 1:
                [banner lockNativeAdsToOrientation:MPNativeAdOrientationPortrait];
                break;
            case 2:
                [banner lockNativeAdsToOrientation:MPNativeAdOrientationLandscape];
                break;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getPositionX )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t pos = [banner getPositionX];
        FREObject asPos;
        if( [converter FREGetInt:pos asObject:&asPos] == FRE_OK )
        {
            return asPos;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getPositionY )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t pos = [banner getPositionY];
        FREObject asPos;
        if( [converter FREGetInt:pos asObject:&asPos] == FRE_OK )
        {
            return asPos;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getWidth )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t width = [banner getFrameWidth];
        FREObject asWidth;
        if( [converter FREGetInt:width asObject:&asWidth] == FRE_OK )
        {
            return asWidth;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getHeight )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t height = [banner getFrameHeight];
        FREObject asHeight;
        if( [converter FREGetInt:height asObject:&asHeight] == FRE_OK )
        {
            return asHeight;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setPositionX )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t posX;
        if( [converter FREGetObject:argv[0] asInt:&posX] != FRE_OK ) return NULL;
        [banner setPositionX:posX];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setPositionY )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t posY;
        if( [converter FREGetObject:argv[0] asInt:&posY] != FRE_OK ) return NULL;
        [banner setPositionY:posY];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setWidth )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t width;
        if( [converter FREGetObject:argv[0] asInt:&width] != FRE_OK ) return NULL;
        [banner setFrameWidth:width];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setHeight )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t height;
        if( [converter FREGetObject:argv[0] asInt:&height] != FRE_OK ) return NULL;
        [banner setFrameHeight:height];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setSize )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t size;
        if( [converter FREGetObject:argv[0] asInt:&size] != FRE_OK ) return NULL;
        [banner setAdSize:size];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getCreativeWidth )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t width = [banner getCreativeWidth];
        FREObject asWidth;
        if( [converter FREGetInt:width asObject:&asWidth] == FRE_OK )
        {
            return asWidth;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getCreativeHeight )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        int32_t height = [banner getCreativeHeight];
        FREObject asHeight;
        if( [converter FREGetInt:height asObject:&asHeight] == FRE_OK )
        {
            return asHeight;
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( loadBanner )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        [banner loadBanner];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( showBanner )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        [banner showBanner];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( removeBanner )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        [banner removeBanner];
    }
    return NULL;
}

void MoPubContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction functionMap[] =
    {
        MAP_FUNCTION( initialiseBanner, NULL ),
        
        MAP_FUNCTION( setAdUnitId, NULL ),
        MAP_FUNCTION( setAutorefresh, NULL ),
        MAP_FUNCTION( setTestMode, NULL ),
        MAP_FUNCTION( lockNativeAdsToOrientation, NULL ),
        
        MAP_FUNCTION( getPositionX, NULL ),
        MAP_FUNCTION( setPositionX, NULL ),
        MAP_FUNCTION( getPositionY, NULL ),
        MAP_FUNCTION( setPositionY, NULL ),
        MAP_FUNCTION( getWidth, NULL ),
        MAP_FUNCTION( setWidth, NULL ),
        MAP_FUNCTION( getHeight, NULL ),
        MAP_FUNCTION( setHeight, NULL ),
        
        MAP_FUNCTION( setSize, NULL ),
        MAP_FUNCTION( getCreativeWidth, NULL ),
        MAP_FUNCTION( getCreativeHeight, NULL ),
        
        MAP_FUNCTION( loadBanner, NULL ),
        MAP_FUNCTION( showBanner, NULL ),
        MAP_FUNCTION( removeBanner, NULL )
    };
 
	*numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
	*functionsToSet = functionMap;
}

void MoPubContextFinalizer( FREContext ctx )
{
    MoPubBanner* banner;
    FREGetContextNativeData( ctx, (void**)&banner );
    if( banner != nil )
    {
        [banner removeFromSuperview];
        [banner release];
    }
	return;
}

void MoPubExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
    extDataToSet = NULL;
    *ctxInitializerToSet = &MoPubContextInitializer;
    *ctxFinalizerToSet = &MoPubContextFinalizer;
    
    converter = [[[MoPub_TypeConversion alloc] init] retain];
}

void MoPubExtensionFinalizer()
{
    [converter release];
    return;
}