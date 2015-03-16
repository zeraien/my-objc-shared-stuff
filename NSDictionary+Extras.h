//
//  NSDictionary+Extras.h
//  Blockade
//
//  Created by Dimo on 2010-05-06.
//  Copyright 2010 angelhill.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(Extras)
- (void)deepMergeEntriesFrom:(NSDictionary*)otherDict depth:(NSInteger)depth;

@end

@interface NSDictionary (Extras)
- (NSDictionary*)overwriteValuesWithDictionary:(NSDictionary*)dictionary;
@end
