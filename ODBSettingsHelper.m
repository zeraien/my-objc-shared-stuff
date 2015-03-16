/*
 *  FRMacros.h
 *  insults
 *
 *  Created by Dimo on 2010-07-04.
 *  Copyright 2010 angelhill.net. All rights reserved.
 *
 */
#import "ODBSettingsHelper.h"

static const NSUserDefaults* _userDefaults;

#ifdef __cplusplus
extern "C" {
#endif

BOOL ODBDefaultGetBool(NSString* key)
{
    return ODBDefaultGetBoolWithDefault(key, false);
}
int ODBDefaultGetInt(NSString* key)
{
    return ODBDefaultGetIntWithDefault(key, 0);
}
float ODBDefaultGetFloat(NSString* key)
{
    return ODBDefaultGetFloatWithDefault(key, 0);
}

BOOL ODBDefaultGetBoolWithDefault(NSString* key, BOOL defaultValue)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([_userDefaults objectForKey:key])
        return [_userDefaults boolForKey:key];
    else
        return defaultValue;
}
int ODBDefaultGetIntWithDefault(NSString* key, int defaultValue)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    if ([_userDefaults objectForKey:key])
        return [_userDefaults integerForKey:key];
    else
        return defaultValue;

}
float ODBDefaultGetFloatWithDefault(NSString* key, float defaultValue)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    if ([_userDefaults objectForKey:key])
        return [_userDefaults floatForKey:key];
    else
        return defaultValue;

}
inline BOOL ODBDefaultExists(NSString*key)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    return ([_userDefaults objectForKey:key]!=nil);
}
inline void ODBDefaultSetBool(NSString* key, BOOL value)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    [_userDefaults setBool:value forKey:key];
}
inline void ODBDefaultSetInt(NSString* key, int value)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    [_userDefaults setInteger:value forKey:key];
}
inline void ODBDefaultSetFloat(NSString* key, float value)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    [_userDefaults setFloat:value forKey:key];
}

void ODBDefaultSetArray(NSString* key, NSArray * value)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    if (value != nil)
    {
        [_userDefaults setObject:value forKey:key];
    }
    else
        [_userDefaults removeObjectForKey:key];

}

void ODBDefaultSetObject(NSString* key, NSObject * value)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    if (value != nil)
    {
        if (!([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSDate class]]))
            value =  [NSKeyedArchiver archivedDataWithRootObject:value];

        [_userDefaults setObject:value forKey:key];

    }
    else
        [_userDefaults removeObjectForKey:key];

}

id ODBDefaultGetObject(NSString * key)
{
    if (_userDefaults==nil)_userDefaults = [NSUserDefaults standardUserDefaults];
    id data = [_userDefaults objectForKey:key];
    if (data!=nil)
    {
        if ([data isKindOfClass:[NSString class]] || [data isKindOfClass:[NSNumber class]] || [data isKindOfClass:[NSDate class]])
            return data;
        else if ([data isKindOfClass:[NSData class]])
        {
            @try
            {
                return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
            @catch (NSException* error)
            {
                NSLog(@"Error loading stored data for key %@: %@", key, error);
                return nil;
            }
        }
    }
    
    return nil;
}

#ifdef __cplusplus
}
#endif

