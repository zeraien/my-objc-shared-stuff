//
//  NSDate_DayCalcs.h
//  Netigate
//
//  Created by Dimo on 2010-10-12.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (DayCalc)

- (NSDate*)addDays:(NSInteger)days;
- (NSDate*)addYears:(NSInteger)years;
+ (NSDate*)today;

@end
