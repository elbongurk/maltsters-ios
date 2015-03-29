//
//  EGKMaltster.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKMaltster.h"
#import "EGMalt.h"

@implementation EGKMaltster

+ (NSArray *)itemsWithJSON:(NSArray *)JSONArray
{
    if (!JSONArray) return nil;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:JSONArray.count];
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        [array addObject:[[EGKMaltster alloc] initWithJSON:JSONDictionary]];
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
    _name = JSONDictionary[@"name"];
    
    _malts = [EGMalt itemsWithJSON:JSONDictionary[@"malts"]];
    
    return self;
}


@end
