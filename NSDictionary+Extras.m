//
//  NSDictionary+Extras.m
//  Blockade
//
//  Created by Dimo on 2010-05-06.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import "NSDictionary+Extras.h"

@implementation NSMutableDictionary(Extras)

- (void)recursiveMerge:(NSDictionary*)otherDict depthRemaining:(NSInteger)depthRemaining
{
	if (depthRemaining>0)
	{
		NSArray* otherKeys = [otherDict allKeys];
		for (NSString* key in otherKeys)
		{
			id rm_currentDict = [[self objectForKey:key] mutableCopy];
			id newOtherDict = [otherDict objectForKey:key];
			
			
			if (rm_currentDict==nil)
			{
				rm_currentDict = [newOtherDict mutableCopy];
			}
			else
			{
				if ([newOtherDict isKindOfClass:[NSArray class]] && [rm_currentDict isKindOfClass:[NSMutableArray class]])
				{
					[rm_currentDict addObjectsFromArray:newOtherDict];
				}
				else
				{
					depthRemaining--;
					
					if (depthRemaining>0)
					{
						[self recursiveMerge:newOtherDict depthRemaining:depthRemaining];
					}
					else
						[rm_currentDict addEntriesFromDictionary:newOtherDict];
				}
			}
			[self setObject:rm_currentDict forKey:key];

			[rm_currentDict release];
		}
	}
}
- (void)deepMergeEntriesFrom:(NSDictionary*)otherDict depth:(NSInteger)depth
{
	[self recursiveMerge:otherDict depthRemaining:depth];
}

@end


@implementation NSDictionary (Extras)



- (NSDictionary*)overwriteValuesWithDictionary:(NSDictionary*)dictionary
{
	if (dictionary == nil || [dictionary count]==0)
		return [[self copy] autorelease];
	
	NSMutableDictionary* dict = [self mutableCopy];
	[dict addEntriesFromDictionary:dictionary];
	return [dict autorelease];
}
@end
