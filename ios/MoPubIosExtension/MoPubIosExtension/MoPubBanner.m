//
//  MoPubBanner.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Richard Lord. All rights reserved.
//

#import "MoPubBanner.h"
#import "MoPub_Messages.h"

@interface MoPubBanner ()
{
}
@property FREContext context;

@end

@implementation MoPubBanner

@synthesize context, key;

- (id) initWithContext:( FREContext ) extensionContext adUnitId:(NSString*)adUnitId size:(CGSize)size
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

- (void) setOriginX:(double)x y:(double)y
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    frame.origin.y = y;
    self.frame = frame;
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view
{
    FREDispatchStatusEventAsync( context, key.UTF8String, bannerLoaded );
}
- (void)adViewDidLoadAd:(MPAdView *)view
{
    FREDispatchStatusEventAsync( context, key.UTF8String, bannerFailedToLoad );
}


@end
