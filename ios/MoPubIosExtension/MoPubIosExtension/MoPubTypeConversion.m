//
//  MoPubTypeConversion.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import "MoPubTypeConversion.h"

@implementation MoPub_TypeConversion

- (FREResult) FREGetObject:(FREObject)object asInt:(int32_t*)value
{
    return FREGetObjectAsInt32( object, value );
}

- (FREResult) FREGetObject:(FREObject)object asDouble:(double*)value
{
    return FREGetObjectAsDouble( object, value );
}

- (FREResult) FREGetObject:(FREObject)object asBoolean:(uint32_t*)value
{
    return FREGetObjectAsBool( object, value );
}

- (FREResult) FREGetObject:(FREObject)object asString:(NSString**)value
{
    FREResult result;
    uint32_t length = 0;
    const uint8_t* tempValue = NULL;
    
    result = FREGetObjectAsUTF8( object, &length, &tempValue );
    if( result != FRE_OK ) return result;
    
    *value = [NSString stringWithUTF8String: (char*) tempValue];
    return FRE_OK;
}

- (FREResult) FREGetString:(NSString*)string asObject:(FREObject*)asObject
{
    if( string == nil )
    {
        return FRE_INVALID_ARGUMENT;
    }
    const char* utf8String = string.UTF8String;
    unsigned long length = strlen( utf8String );
    return FRENewObjectFromUTF8( length + 1, (uint8_t*) utf8String, asObject );
}


- (FREResult) FREGetDouble:(double)value asObject:(FREObject*)asObject
{
    return FRENewObjectFromDouble( value, asObject );
}

@end
