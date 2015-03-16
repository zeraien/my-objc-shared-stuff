//
//  FileManager.m
//  Final Rage
//
//  Created by Dimo on 2009-10-02.
//  Copyright 2009 angelhill.net. All rights reserved.
//

#import "ODBFileManager.h"
#import "ODBMacros.h"

#define APP_CACHE_FILENAME @"applicationCache.plist"

@interface ODBFileManager (Private)

+ (NSString*)writeFile:(NSString*)filename withData:(NSData*)data;

@end

@implementation ODBFileManager

+ (id)allocWithZone:(NSZone *)zone
{
    return nil; //on subsequent allocation attempts return nil
}

+ (BOOL)deleteFileInCache:(NSString*)filename
{
	NSError *error;
	NSString *appFile = [self fullpathOfFilenameInCache:filename];
	BOOL deleted = [[NSFileManager defaultManager] removeItemAtPath:appFile error:&error];
	if (!deleted){
		ODBLOG(@"File %@ was not deleted because: %@", appFile, error);
	}
	return deleted;
}

+ (BOOL)deleteFileInDocuments:(NSString*)filename
{
	NSError *error;
	NSString *appFile = [self fullpathOfFilename:filename];
	BOOL deleted = [[NSFileManager defaultManager] removeItemAtPath:appFile error:&error];
	if (!deleted){
		ODBLOG(@"File %@ was not deleted because: %@", appFile, error);
	}
	return deleted;
}

+(NSString*) fullPathFromRelativePath:(NSString*) relPath
{
	// do not convert an absolute path (starting with '/')
	if(([relPath length] > 0) && ([relPath characterAtIndex:0] == '/'))
	{
		return relPath;
	}
	
	NSMutableArray *imagePathComponents = [NSMutableArray arrayWithArray:[relPath pathComponents]];
	NSString *file = [imagePathComponents lastObject];
	
	[imagePathComponents removeLastObject];
	NSString *imageDirectory = [NSString pathWithComponents:imagePathComponents];
	
	NSString *fullpath = [[NSBundle mainBundle] pathForResource:file
														 ofType:nil
													inDirectory:imageDirectory];
	if (fullpath == nil)
		fullpath = relPath;
	
	return fullpath;	
}

+ (NSString*)applicationFile:(NSString*)filename allowDownloadOverride:(BOOL)allowDownloadOverride
{
	NSString* path = nil;
	if (allowDownloadOverride)
	{
		path = [self fullpathOfFilenameIfExists:[@"downloads" stringByAppendingPathComponent:filename]];
	}
	if (path == nil)
	{
		path = [self fullPathFromRelativePath:filename];
		if (![[NSFileManager defaultManager] isReadableFileAtPath:path])
			path = nil;
	}
	
	return path;
	
}


+ (NSString*)fullpathOfFilenameIfExistsInCache:(NSString*)filename
{
	NSString* custom = [self fullpathOfFilenameInCache:filename];
	
	BOOL exists = [[NSFileManager defaultManager] isReadableFileAtPath:custom];
	
	if (exists)
		return custom;
	else
		return nil;
}

+ (NSString*)fullpathOfFilenameIfExists:(NSString*)filename
{
	NSString* custom = [self fullpathOfFilename:filename];
	
	BOOL exists = [[NSFileManager defaultManager] isReadableFileAtPath:custom];
	
	if (exists)
		return custom;
	else
		return nil;
}

+ (NSString*)fullpathOfFilename:(NSString*)filename
{
	if ([filename characterAtIndex:0]=='/')
		return [[filename retain]autorelease];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	
	if (!directory) {
		ODBLOG(@"Requested directory not found!");
		return nil;
	} else {  
		NSString *appFile = [directory stringByAppendingPathComponent:filename];
		return appFile;
	}
}

+ (NSString*)fullpathOfFilenameInCache:(NSString*)filename
{
	if ([filename characterAtIndex:0]=='/')
		return [[filename retain]autorelease];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	
	if (!directory) {
		ODBLOG(@"Requested directory not found!");
		return nil;
	} else {  
		NSString *appFile = [directory stringByAppendingPathComponent:filename];
		return appFile;
	}
}

+ (NSString*)writeFileToDocuments:(NSString*)filename withData:(NSData*)data
{
	NSString *appFile = [self fullpathOfFilename:filename];
	return [self writeFile:appFile withData:data];
}

+ (NSString*)writeFileToCache:(NSString*)filename withData:(NSData*)data
{
	NSString *appFile = [self fullpathOfFilenameInCache:filename];
	return [self writeFile:appFile withData:data];
}

+ (NSString*)writeFile:(NSString*)filename withData:(NSData*)data
{
	ODBLOG(@"Writing %@", filename);
	
	NSError *pError = nil;
	[data writeToFile:filename options:0 error:&pError];
	
	if (pError != nil)
	{
		ODBLOG(@"Error writing %@: %@", filename, pError);
		return nil;
	}
	return filename;
}

+ (NSData *)readFileInDocuments:(NSString *)filename {
	NSString *appFile = [self fullpathOfFilename:filename];
	return [[[NSData alloc] initWithContentsOfFile:appFile] autorelease];
}
+ (NSData *)readFileInCache:(NSString *)filename {
	NSString *appFile = [self fullpathOfFilenameInCache:filename];
	return [[[NSData alloc] initWithContentsOfFile:appFile] autorelease];
}

+ (id)loadObjectFromPlistAtPath:(NSString *)path
{
	NSData *rm_data = nil;
	NSString *error = nil;
	id retPlist = nil;
	
	NSPropertyListFormat format;
	rm_data = [[NSData alloc] initWithContentsOfFile:path];
	if (!rm_data) {
		//ODBLOG(@"resources file not returned.");
		return nil;
	}
	retPlist = [NSPropertyListSerialization propertyListFromData:rm_data  mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
	if (!retPlist){
		ODBLOG(@"Plist not returned, error: %@", error);
	}
	if (error) [error release];
	
	[rm_data release];
	
	return retPlist;
}

+ (BOOL)writeObject:(id)plist toPlistAtPath:(NSString *)path
{
	NSString *error;
	
	NSData *pData = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListBinaryFormat_v1_0 errorDescription:&error];
	
	if (!pData) {
		
		ODBLOG(@"Error writing application plist: %@",error);
		return NO;
	}
	if (error)[error release];
	
	return ([self writeFile:path withData:pData] != nil);
}

+ (BOOL)writeObject:(id)plist toPlistFilenameInCache:(NSString *)filename
{
	return [self writeObject:plist toPlistAtPath:[self fullpathOfFilenameInCache:filename]];
}
+ (BOOL)writeObject:(id)plist toPlistFilenameInDocuments:(NSString *)fileName
{
	return [self writeObject:plist toPlistAtPath:[self fullpathOfFilename:fileName]];
}

+ (id)loadObjectFromPlistFilenameInDocuments:(NSString *)fileName {
	return [self loadObjectFromPlistAtPath:[self fullpathOfFilename:fileName]];
}


@end
