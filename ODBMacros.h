/*
 *  FRMacros.h
 *  insults
 *
 *  Created by Dimo on 2010-07-04.
 *  Copyright 2010 angelhill.net. All rights reserved.
 *
 */
#import "ODBSettingsHelper.h"

#define ODBsprintf(format, ...) [NSString stringWithFormat:format, ## __VA_ARGS__]
#define ODBUpperStr(format, ...) [[NSString stringWithFormat:format, ## __VA_ARGS__] uppercaseString]
#define ODBLowerStr(format, ...) [[NSString stringWithFormat:format, ## __VA_ARGS__] lowercaseString]

#define trans(__string) NSLocalizedString(__string, @"")

#define NOW_SECS (int)round([[NSDate date] timeIntervalSince1970])

#if __TEST_FLIGHT__
#define testFlightCheckpoint(__checkpointName) [TestFlight passCheckpoint:__checkpointName]
#else
#define testFlightCheckpoint(__checkpointName) do {} while (0)
#endif

#if DEBUG_LOG>=2
#define ODBLOG2(...) NSLog(__VA_ARGS__)
#else
#define ODBLOG2(...) do {} while (0)
#endif

#if DEBUG_LOG>=1
#define ODBLOG1(...) NSLog(__VA_ARGS__)
#else
#define ODBLOG1(...) do {} while (0)
#endif

#if DEBUG || __DEBUG__ || DEBUG_LOG>0
#define ODBLOG(...) NSLog(__VA_ARGS__)
#else
#define ODBLOG(...) do {} while (0)
#endif

#define respondsTo(__obj__, __sel__) [__obj__ respondsToSelector:@selector(__sel__)]

#define screenScale() ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]?[UIScreen mainScreen].scale:1.0f)

//Memory management
#if __has_feature(objc_arc)
#define _set(__objcObject__) __objcObject__
#define BMakeReleased(ocObject) ocObject
#define BSafeRelease(ocObject) ocObject = nil;
#define BSafeSetRetain(ocObject, value) ocObject = value;
#define BSafeSetCopy(ocObject, value) ocObject = [value copy];
#else
#define _set(__objcObject__) [__objcObject__ release]; __objcObject__
#define BMakeReleased(ocObject) [ocObject release]; ocObject
#define BSafeRelease(ocObject) [ocObject release]; ocObject = nil;
#define BSafeSetRetain(ocObject, value) [ocObject release]; ocObject = [value retain];
#define BSafeSetCopy(ocObject, value) [ocObject release]; ocObject = [value copy];
#endif

#define SECONDS_IN_A_DAY 86400

#define ISNULL(__string_value__) (__string_value__ == nil || ([NSNull null] == (NSNull*)__string_value__) || [__string_value__ isEqualToString:@""])
#define NOTNULL(__string_value__) !ISNULL(__string_value__)
#define MAKE_NSNULL_IF_NIL(__string_value__) (__string_value__==nil?(id)[NSNull null]:(id)__string_value__)
#define MAKE_EMPTY_STRING_IF_NIL(__string_value__) (__string_value__==nil?(id)@"":(id)__string_value__)

#define SecondsPassedSinceDateTime(__DATETIME__,__SEC__) (__DATETIME__==nil||[[NSDate date] timeIntervalSince1970]-[__DATETIME__ timeIntervalSince1970] > __SEC__)
#define MinutesPassedSinceDateTime(__DATETIME__,__MINUTES__) (__DATETIME__==nil||[[NSDate date] timeIntervalSince1970]-[__DATETIME__ timeIntervalSince1970] > __MINUTES__*60.)
#define DaysPassedSinceDateTime(__DATETIME__,__DAYS__) (__DATETIME__==nil||[[NSDate date] timeIntervalSince1970]-[__DATETIME__ timeIntervalSince1970] > __DAYS__*3600.)
#define DaysUntilDateTime(__DATETIME__) (__DATETIME__==nil?0:([__DATETIME__ timeIntervalSince1970]-[[NSDate date] timeIntervalSince1970])/SECONDS_IN_A_DAY)

#define getUserCachesFolderPath() [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define getUserDocumentsFolderPath() [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

