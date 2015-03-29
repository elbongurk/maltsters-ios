//
//  EGLot.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGLot.h"
#import "EGAnalysis.h"

@implementation EGLot

+ (NSArray *)itemsWithJSON:(NSArray *)JSONArray
{
    if (!JSONArray) return nil;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:JSONArray.count];
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        [array addObject:[[EGLot alloc] initWithJSON:JSONDictionary]];
    }
    
    return array;
}

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _identifier = JSONDictionary[@"id"];
    _code = JSONDictionary[@"code"];
    
    id value = JSONDictionary[@"analysis"];
    if (value && value != [NSNull null]) {
        _analysis = [[EGAnalysis alloc] initWithJSON:value];
    }
    
    return self;
}

@end
