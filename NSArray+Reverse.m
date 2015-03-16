//
//  NSArray+Reverse.m
//  Blockade
//
//  Created by Dimo on 2010-04-02.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import "NSArray+Reverse.h"


@implementation NSArray (Reverse)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end

@implementation NSMutableArray (Reverse)

- (void)reverse {
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
		
        i++;
        j--;
    }
}

@end

