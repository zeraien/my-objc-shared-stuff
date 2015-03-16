//
//  MyString.h
//  insults
//
//  Created by Dmitri Fedortchenko on 2009-06-06.
//  Copyright 2009 angelhill.net. All rights reserved.
//


@interface NSString (Utilities)
- (NSString *)strip;
- (NSString *)capfirst;
- (NSString *)stringByDecodingXMLEntities;
- (NSString *)urlencode;
- (NSString *)sha1;
- (NSString *)md5;
- (NSString* )stripNonAsciiChars;

@end
