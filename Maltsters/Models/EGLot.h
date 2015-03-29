//
//  EGLot.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGAnalysis;

@interface EGLot : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) EGAnalysis *analysis;

+ (NSArray *)itemsWithJSON:(NSArray *)JSONArray;

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;

@end
