//
//  EGMalt.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGMalt.h"
#import "EGLot.h"
#import "EGAnalysis.h"

@implementation EGMalt

+ (NSArray *)itemsWithJSON:(NSArray *)JSONArray
{
    if (!JSONArray) return nil;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:JSONArray.count];
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        [array addObject:[[EGMalt alloc] initWithJSON:JSONDictionary]];
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
    _type = JSONDictionary[@"type"];
    
    _lots = [EGLot itemsWithJSON:JSONDictionary[@"lots"]];
    
    id value = JSONDictionary[@"analysis"];
    if (value && value != [NSNull null]) {
        _analysis = [[EGAnalysis alloc] initWithJSON:value];
    }
    
    return self;
}

@end
