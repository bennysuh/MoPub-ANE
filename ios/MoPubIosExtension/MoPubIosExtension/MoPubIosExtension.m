//
//  MoPubIosExtension.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "MoPub_TypeConversion.h"
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
    
    MoPubBanner* banner = [[MoPubBanner alloc] initWithAdUnitId:adUnitId size:adType];
    [banner retain];
    FRESetContextNativeData( context, banner );
    return NULL;
}

DEFINE_ANE_FUNCTION( getDisplayDensity )
{
    double density = [UIScreen mainScreen].scale;
    FREObject asDensity;
    if( [converter FREGetDouble:density asObject:&asDensity] == FRE_OK )
    {
        return asDensity;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setTestMode )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        uint32_t test;
        if( [converter FREGetObject:argv[0] asBoolean:&test] != FRE_OK ) return NULL;
        BOOL testing = ( test == 1 );
        [banner setTestMode:testing];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( setPositionX )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        double posX;
        if( [converter FREGetObject:argv[0] asDouble:&posX] != FRE_OK ) return NULL;
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
        double posY;
        if( [converter FREGetObject:argv[0] asDouble:&posY] != FRE_OK ) return NULL;
        [banner setPositionY:posY];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( getCreativeWidth )
{
    MoPubBanner* banner;
    FREGetContextNativeData( context, (void**)&banner );
    if( banner != nil )
    {
        double width = [banner getCreativeWidth];
        FREObject asWidth;
        if( [converter FREGetDouble:width asObject:&asWidth] == FRE_OK )
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
        double height = [banner getCreativeHeight];
        FREObject asHeight;
        if( [converter FREGetDouble:height asObject:&asHeight] == FRE_OK )
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
        MAP_FUNCTION( getDisplayDensity, NULL ),
        MAP_FUNCTION( setTestMode, NULL ),
        MAP_FUNCTION( setPositionX, NULL ),
        MAP_FUNCTION( setPositionY, NULL ),
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