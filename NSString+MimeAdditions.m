//
//  MyString.m
//  insults
//
//  Created by Dmitri Fedortchenko on 2009-06-06.
//  Copyright 2009 angelhill.net. All rights reserved.
//

#import "NSString+MimeAdditions.h"


@implementation NSString (MIMEAdditions)
//this returns a unique boundary which is used in constructing the multipart MIME body of the POST request
+ (NSString*)MIMEBoundary
{
    static NSString* MIMEBoundary = nil;
    if(!MIMEBoundary)
        MIMEBoundary = [[NSString alloc] initWithFormat:@"----_=OneDayBeardThing%@_=_----",[[NSProcessInfo processInfo] globallyUniqueString]];
    return MIMEBoundary;
}
//this create a correctly structured multipart MIME body for the POST request from a dictionary
+ (NSString*)multipartMIMEStringWithDictionary:(NSDictionary*)dict 
{
    NSMutableString* result = [NSMutableString string];
    for (NSString* key in dict)
    {
        [result appendFormat:@"--%@\nContent-Disposition: form-data; name=\"%@\"\n\n%@\n",[NSString MIMEBoundary],key,[dict objectForKey:key]];
    }
    [result appendFormat:@"\n--%@--\n",[NSString MIMEBoundary]];
    return result;
}
@end

