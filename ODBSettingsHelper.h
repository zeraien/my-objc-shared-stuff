/*
 *  FRMacros.h
 *  insults
 *
 *  Created by Dimo on 2010-07-04.
 *  Copyright 2010 angelhill.net. All rights reserved.
 *
 */

#define ODBDefaultDeleteObject(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]


#ifdef __cplusplus
extern "C" {
#endif

BOOL ODBDefaultGetBool(NSString* key);
int ODBDefaultGetInt(NSString* key);
float ODBDefaultGetFloat(NSString* key);

BOOL ODBDefaultGetBoolWithDefault(NSString* key, BOOL defaultValue);
int ODBDefaultGetIntWithDefault(NSString* key, int defaultValue);
float ODBDefaultGetFloatWithDefault(NSString* key, float defaultValue);

id ODBDefaultGetObject(NSString * key);


void ODBDefaultSetBool(NSString* key, BOOL value);
void ODBDefaultSetInt(NSString* key, int value);
void ODBDefaultSetFloat(NSString* key, float value);

void ODBDefaultSetObject(NSString* key, NSObject * value);
void ODBDefaultSetArray(NSString* key, NSArray * value);

BOOL ODBDefaultExists(NSString* key);


    
#ifdef __cplusplus
}
#endif

#define ODB_GetUUID() ODBDefaultGetObject(@"UUID")
