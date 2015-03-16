//
//  MyString.h
//  insults
//
//  Created by Dmitri Fedortchenko on 2009-06-06.
//  Copyright 2009 angelhill.net. All rights reserved.
//

@interface NSString (MIMEAdditions)
+ (NSString*)MIMEBoundary;
+ (NSString*)multipartMIMEStringWithDictionary:(NSDictionary*)dict;
@end
