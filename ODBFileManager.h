//
//  FileManager.h
//  Final Rage
//
//  Created by Dimo on 2009-10-02.
//  Copyright 2009 angelhill.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODBFileManager : NSObject

+ (NSString*)fullPathFromRelativePath:(NSString*) relPath;

+ (NSString*)fullpathOfFilenameIfExists:(NSString*)filename;
+ (NSString*)fullpathOfFilenameIfExistsInCache:(NSString*)filename;
+ (NSString*)fullpathOfFilenameInCache:(NSString*)filename;
+ (NSString*)fullpathOfFilename:(NSString*)filename;

/** Return full path to specified file, if download override is YES, we will look in the "downloads" folder first. 
 @return Full path to the file, or `nil` if the file does not exist.
 */
+ (NSString*)applicationFile:(NSString*)filename allowDownloadOverride:(BOOL)allowDownloadOverride;

+ (id)loadObjectFromPlistFilenameInDocuments:(NSString *)filename;
+ (id)loadObjectFromPlistAtPath:(NSString *)path;

+ (BOOL)writeObject:(id)plist toPlistFilenameInDocuments:(NSString *)filename;
+ (BOOL)writeObject:(id)plist toPlistFilenameInCache:(NSString *)filename;
+ (BOOL)writeObject:(id)plist toPlistAtPath:(NSString *)path;

+ (NSString*)writeFileToCache:(NSString*)filename withData:(NSData*)data;
+ (NSString*)writeFileToDocuments:(NSString*)filename withData:(NSData*)data;

+ (NSData *)readFileInDocuments:(NSString *)filename;
+ (NSData *)readFileInCache:(NSString *)filename;

+ (BOOL)deleteFileInDocuments:(NSString*)filename;
+ (BOOL)deleteFileInCache:(NSString*)filename;

@end
