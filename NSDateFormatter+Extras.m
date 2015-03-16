//
//  SharedFunctions.m
//  Blockade
//
//  Created by Dimo on 2010-03-11.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import "NSDateFormatter+Extras.h"
#import "GameTypes.h"
#import "NSString-Utilities.h"
#define secondsPerDay 86400


@implementation NSDateFormatter (Extensions)

+ (NSString*)fancyTimeDisplay:(NSDate*)date
{
	NSDateFormatter* rm_form = [[NSDateFormatter alloc] init];
	NSString* lastPlayedStr = nil;
	if (date!=nil)
	{
		if ([[NSDate date] timeIntervalSinceDate:date] > secondsPerDay )
		{
			//[rm_form setDateStyle:NSDateFormatterMediumStyle];
			[rm_form setDateFormat:@"d MMM"];
			lastPlayedStr = [rm_form stringFromDate:date];
		}
		else {
			[rm_form setDateStyle:NSDateFormatterNoStyle];
			[rm_form setTimeStyle:NSDateFormatterShortStyle];
			lastPlayedStr = [rm_form stringFromDate:date];
			//lastPlayedStr = [NSString stringWithFormat:NSLocalizedString(@"Today at %@",@"today+time"),[rm_form stringFromDate:date]];
		}
	}
	else
	{
		lastPlayedStr = NSLocalizedString(@"Never",@"never played it");
	}
	
	[rm_form release];
	return lastPlayedStr;
}	

+ (NSString*)durationString:(NSTimeInterval)since
{
	NSInteger secs = (int)floor(since);
	
	NSString* timeString = @"";
	
	if (secs < 3600)
	{
		int seconds = secs%60;
		timeString = [NSString stringWithFormat:_(@"%ds"),seconds];
		secs -= seconds;
	}
	
	if (secs > 0)
	{
		int newSecs = secs%3600;
		int minutes = (newSecs/60);
		secs -= newSecs;
		timeString = [NSString stringWithFormat:_(@"%dm %@"),minutes, timeString];
	}
	
	if (secs >= 3600)
	{
		int newSecs = secs%86400;
		int hours = (newSecs/3600);
		secs -= newSecs;
		
		timeString = [NSString stringWithFormat:_(@"%dh %@"), hours, timeString];
	}
	
	if (secs >= 86400)
	{
		timeString = [NSString stringWithFormat:_(@"%dd %@"),(secs/86400),timeString];
	}
	
	return [timeString strip];
}

@end
