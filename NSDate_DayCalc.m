//
//  NSDate_DayCalcs.m
//  Netigate
//
//  Created by Dimo on 2010-10-12.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import "NSDate_DayCalc.h"


@implementation NSDate (DayCalc)

+ (NSDate*)today
{
	NSCalendar *rm_gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *rm_components = [[rm_gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit) fromDate:[NSDate date]]retain];
	[rm_components setHour:0];
	[rm_components setMinute:0];
	[rm_components setSecond:0];
	
	NSDate* today = [[rm_gregorian dateFromComponents:rm_components] retain];
	[rm_components release];
	[rm_gregorian release];

	return [today autorelease];
}

- (NSDate*)dateByAddingTimeInterval:(NSTimeInterval)seconds
{
	return [NSDate dateWithTimeIntervalSince1970:[self timeIntervalSince1970]+seconds];
}

- (NSDate*)addYears:(NSInteger)years
{
	NSCalendar *rm_gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *rm_offsetComponents = [[NSDateComponents alloc] init];
	[rm_offsetComponents setYear:years];
	NSDate *calculatedDate = [rm_gregorian dateByAddingComponents:rm_offsetComponents toDate:self options:0];
	[rm_offsetComponents release];
	[rm_gregorian release];
	
	return calculatedDate;
}

- (NSDate*)addDays:(NSInteger)days
{
	NSCalendar *rm_gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *rm_offsetComponents = [[NSDateComponents alloc] init];
	[rm_offsetComponents setDay:days];

	NSDate *calculatedDate = [rm_gregorian dateByAddingComponents:rm_offsetComponents toDate:self options:0];
	[rm_offsetComponents release];
	[rm_gregorian release];
	
	return calculatedDate;
}
@end
