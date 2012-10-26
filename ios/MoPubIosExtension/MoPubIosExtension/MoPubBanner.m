//
//  MoPubBanner.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import "MoPubBanner.h"
#import "MoPub_TypeConversion.h"
#import "MoPub_Messages.h"

@interface MoPubBanner ()
{
}
@property (nonatomic, assign)FREContext context;

@end

@implementation MoPubBanner

@synthesize context;

- (id) initWithContext:(FREContext)extensionContext adUnitId:(NSString*)adUnitId size:(CGSize)size
{
    self = [super initWithAdUnitId:adUnitId size:size];
    if( self )
    {
        self.context = extensionContext;
        self.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

+ (CGSize) getAdSizeFromSizeId:(int) sizeId
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

- (void) setPositionX:(double)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (void) setPositionY:(double)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (double) getCreativeWidth
{
    return [self adContentViewSize].width;
}

- (double) getCreativeHeight
{
    return [self adContentViewSize].height;
}

- (void) loadBanner
{
    [self loadAd];
}

- (void) showBanner
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
}

- (void) removeBanner
{
    [self removeFromSuperview];
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view
{
    FREDispatchStatusEventAsync( context, "", bannerLoaded );
}
- (void)adViewDidLoadAd:(MPAdView *)view
{
    FREDispatchStatusEventAsync( context, "", bannerFailedToLoad );
}


@end
