//
//  MoPub_TypeConversion.m
//  MoPubIosExtension
//
//  Created by Richard Lord on 23/10/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import "MoPub_TypeConversion.h"

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

- (FREResult) FREGetDate:(NSDate*)date asObject:(FREObject*)asDate
{
    if( date == nil )
    {
        return FRE_INVALID_ARGUMENT;
    }
    NSTimeInterval timestamp = date.timeIntervalSince1970 * 1000;
    FREResult result;
    FREObject time;
    result = FRENewObjectFromDouble( timestamp, &time );
    if( result != FRE_OK ) return result;
    result = FRENewObject( "Date", 0, NULL, asDate, NULL );
    if( result != FRE_OK ) return result;
    result = FRESetObjectProperty( *asDate, "time", time, NULL);
    if( result != FRE_OK ) return result;
    return FRE_OK;
}

- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toString:(NSString*)value
{
    if( value == nil )
    {
        return FRE_INVALID_ARGUMENT;
    }
    FREResult result;
    FREObject asValue;
    result = [self FREGetString:value asObject:&asValue];
    if( result != FRE_OK ) return result;
    result = FRESetObjectProperty( asObject, propertyName, asValue, NULL );
    if( result != FRE_OK ) return result;
    return FRE_OK;
}

- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toBool:(uint32_t)value
{
    FREResult result;
    FREObject asValue;
    result = FRENewObjectFromBool( value, &asValue );
    if( result != FRE_OK ) return result;
    result = FRESetObjectProperty( asObject, propertyName, asValue, NULL );
    if( result != FRE_OK ) return result;
    return FRE_OK;
}

- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toInt:(int32_t)value
{
    FREResult result;
    FREObject asValue;
    result = FRENewObjectFromInt32( value, &asValue );
    if( result != FRE_OK ) return result;
    result = FRESetObjectProperty( asObject, propertyName, asValue, NULL );
    if( result != FRE_OK ) return result;
    return FRE_OK;
}

- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toDouble:(double)value
{
    FREResult result;
    FREObject asValue;
    result = FRENewObjectFromDouble( value, &asValue );
    if( result != FRE_OK ) return result;
    result = FRESetObjectProperty( asObject, propertyName, asValue, NULL );
    if( result != FRE_OK ) return result;
    return FRE_OK;
}

- (FREResult) FRESetObject:(FREObject)asObject property:(const uint8_t*)propertyName toDate:(NSDate*)value
{
    if( value == nil )
    {
        return FRE_INVALID_ARGUMENT;
    }
    FREResult result;
    FREObject asValue;
    result = [self FREGetDate:value asObject:&asValue];
    if( result != FRE_OK ) return result;
    result = FRESetObjectProperty( asObject, propertyName, asValue, NULL );
    if( result != FRE_OK ) return result;
    return FRE_OK;
}

@end
