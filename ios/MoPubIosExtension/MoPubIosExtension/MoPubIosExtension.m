//
//  MoPubIosExtension.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "MoPubHandler.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

MoPubHandler* MoPub_handler;

DEFINE_ANE_FUNCTION( getDisplayDensity )
{
    return [MoPub_handler getDisplayDensity];
}

DEFINE_ANE_FUNCTION( setTestMode )
{
    return [MoPub_handler setTestMode:argv[0]];
}

DEFINE_ANE_FUNCTION( loadBanner )
{
    return [MoPub_handler loadBannerWithAdUnitId:argv[0] size:argv[1]];
}

DEFINE_ANE_FUNCTION( setBannerLocation )
{
    return [MoPub_handler setLocationX:argv[1] y:argv[2] onBanner:argv[0]];
}

DEFINE_ANE_FUNCTION( showBanner )
{
    return [MoPub_handler showBanner:argv[0]];
}

DEFINE_ANE_FUNCTION( loadAndShowBanner )
{
    return [MoPub_handler loadAndShowBannerWithAdUnitId:argv[0] size:argv[1] x:argv[2] y:argv[3]];
}

DEFINE_ANE_FUNCTION( removeBanner )
{
    return [MoPub_handler removeBanner:argv[0]];
}

DEFINE_ANE_FUNCTION( releaseBanner )
{
    return [MoPub_handler releaseBanner:argv[0]];
}

DEFINE_ANE_FUNCTION( removeAndReleaseBanner )
{
    return [MoPub_handler removeAndReleaseBanner:argv[0]];
}

void MoPubContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction functionMap[] =
    {
        MAP_FUNCTION( getDisplayDensity, NULL ),
        MAP_FUNCTION( setTestMode, NULL ),
        MAP_FUNCTION( loadBanner, NULL ),
        MAP_FUNCTION( setBannerLocation, NULL ),
        MAP_FUNCTION( showBanner, NULL ),
        MAP_FUNCTION( loadAndShowBanner, NULL ),
        MAP_FUNCTION( removeBanner, NULL ),
        MAP_FUNCTION( releaseBanner, NULL ),
        MAP_FUNCTION( removeAndReleaseBanner, NULL )
    };
    
	*numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
	*functionsToSet = functionMap;
    
    MoPub_handler = [[MoPubHandler alloc] initWithContext:ctx];
}

void MoPubContextFinalizer( FREContext ctx )
{
	return;
}

void MoPubExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
    extDataToSet = NULL;  // This example does not use any extension data.
    *ctxInitializerToSet = &MoPubContextInitializer;
    *ctxFinalizerToSet = &MoPubContextFinalizer;
}

void MoPubExtensionFinalizer()
{
    return;
}