//
//  MyString.m
//  insults
//
//  Created by Dmitri Fedortchenko on 2009-06-06.
//  Copyright 2009 angelhill.net. All rights reserved.
//

#import "NSString-Utilities.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@implementation NSString (Utilities) 

- (NSString *)md5
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5([self UTF8String],[self length],result);
    
    
    NSMutableString *hexdigest = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH * 2 ];
   	for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
   	{
   		[hexdigest appendFormat:@"%02x", result[i]];
   	}

	return hexdigest;
}
- (NSString *)sha256
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(cStr, strlen(cStr), result);
    
    NSMutableString *hexdigest = [NSMutableString stringWithCapacity: CC_SHA256_DIGEST_LENGTH * 2 ];
   	for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
   	{
   		[hexdigest appendFormat:@"%02x", result[i]];
   	}

	return hexdigest;	
}

- (NSString *)sha1
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(cStr, strlen(cStr), result);
    
    NSMutableString *hexdigest = [NSMutableString stringWithCapacity: CC_SHA1_DIGEST_LENGTH * 2 ];
   	for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
   	{
   		[hexdigest appendFormat:@"%02x", result[i]];
   	}

	return hexdigest;	
}

- (NSString* )stripNonAsciiChars
{
    NSMutableString *asciiCharacters = [NSMutableString string];
    for (NSInteger i = 32; i < 127; i++)  {
        [asciiCharacters appendFormat:@"%c", i];
    }
    
    NSCharacterSet *nonAsciiCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:asciiCharacters] invertedSet];
    
    return [[self componentsSeparatedByCharactersInSet:nonAsciiCharacterSet] componentsJoinedByString:@""];
}

- (NSString *) urlencode
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@" ", @";" , @"/" , @"?" , @":" ,
							@"@" , @"&" , @"=" , @"+" ,
							@"$" , @"," , @"[" , @"]",
							@"#", @"!", @"'", @"(", 
							@")", @"*", nil];
	
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%20", @"%3B" , @"%2F" , @"%3F" ,
							 @"%3A" , @"%40" , @"%26" ,
							 @"%3D" , @"%2B" , @"%24" ,
							 @"%2C" , @"%5B" , @"%5D", 
							 @"%23", @"%21", @"%27",
							 @"%28", @"%29", @"%2A", nil];
	
    int len = [escapeChars count];
	
    NSMutableString *temp = [self mutableCopy];
	
    int i;
    for(i = 0; i < len; i++)
    {
		
        [temp replaceOccurrencesOfString: [escapeChars objectAtIndex:i]
							  withString:[replaceChars objectAtIndex:i]
								 options:NSLiteralSearch
								   range:NSMakeRange(0, [temp length])];
    }
	
    NSString *out = [NSString stringWithString: temp];
#if !__has_feature(objc_arc)
    [temp release];
#endif

    return out;
}

- (NSString *)capfirst
{
	if ([self length] < 1) return self;
	
	NSString *capfirsted = [NSString stringWithFormat:@"%@%@",
									[[self substringToIndex:1] uppercaseString],
									[self substringFromIndex:1]
								];
	return capfirsted;
}

- (NSString*)strip
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



- (NSString *)stringByDecodingXMLEntities {
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
	
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
	
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
			
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            if (gotNumber) {
                [result appendFormat:@"%C", charCode];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToString:@";" intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
            [scanner scanString:@";" intoString:NULL];
        }
        else {
            NSString *unknownEntity = @"";
            [scanner scanUpToString:@";" intoString:&unknownEntity];
            NSString *semicolon = @"";
            [scanner scanString:@";" intoString:&semicolon];
            [result appendFormat:@"%@%@", unknownEntity, semicolon];
            NSLog(@"Unsupported XML character entity %@%@", unknownEntity, semicolon);
        }
    }
    while (![scanner isAtEnd]);
	
finish:
    return result;
}

@end
