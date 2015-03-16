//
//  SharedFunctions.h
//  Blockade
//
//  Created by Dimo on 2010-03-11.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDateFormatter (Extensions)

+ (NSString*)durationString:(NSTimeInterval)since;
+ (NSString*)fancyTimeDisplay:(NSDate*)date;
   
@end
