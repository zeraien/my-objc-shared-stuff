//
//  NetworkHelper.h
//  ComicReader
//
//  Created by Dimo on 2009-11-27.
//  Copyright 2009 angelhill.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>


@interface NetworkHelper : NSObject {

}
+ (NSString *)hashedISU;
+ (BOOL)connectedToNetwork;

@end
