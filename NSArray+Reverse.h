//
//  NSArray+Reverse.h
//  Blockade
//
//  Created by Dimo on 2010-04-02.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Reverse)
- (NSArray *)reversedArray;
@end

@interface NSMutableArray (Reverse)
- (void)reverse;
@end