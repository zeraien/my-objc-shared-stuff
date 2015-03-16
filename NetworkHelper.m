//
//  NetworkHelper.m
//  ComicReader
//
//  Created by Dimo on 2009-11-27.
//  Copyright 2009 angelhill.net. All rights reserved.
//

#import "NetworkHelper.h"
#import "NSString-Utilities.h"
#include <netinet/in.h>
#import <CommonCrypto/CommonDigest.h>
#import "ODBMacros.h"

@implementation NetworkHelper

+ (NSString *)hashedISU {
	return [ODB_GetUUID() md5];
}

+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
