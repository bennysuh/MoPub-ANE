//
//  TypeConversion.h
//  GameCenterIosExtension
//
//  Created by Richard Lord on 18/06/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "FlashRuntimeExtensions.h"

@interface MoPub_TypeConversion : NSObject

- (FREResult) FREGetObject:(FREObject)object asInt:(int32_t*)value;
- (FREResult) FREGetObject:(FREObject)object asDouble:(double*)value;
- (FREResult) FREGetObject:(FREObject)object asBoolean:(uint32_t*)value;
- (FREResult) FREGetObject:(FREObject)object asString:(NSString**)value;

- (FREResult) FREGetString:(NSString*)string asObject:(FREObject*)asObject;
- (FREResult) FREGetDouble:(double)value asObject:(FREObject*)asObject;
/*
- (FREResult) FREGetDate:(NSDate*)date asObject:(FREObject*)asDate;

- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toString:(NSString*)value;
- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toBool:(uint32_t)value;
- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toInt:(int32_t)value;
- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toDouble:(double)value;
- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toDate:(NSDate*)value;
*/
@end
