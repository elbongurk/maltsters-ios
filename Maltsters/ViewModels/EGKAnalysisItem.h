//
//  EGKAnalysisItem.h
//  Maltsters
//
//  Created by Ryan Krug on 3/10/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGAnalysis;
@class EGMetaAnalysis;

@interface EGKAnalysisItem : NSObject

+ (NSArray *)itemsWithAnalysis:(EGAnalysis *)analysis;

- (instancetype)initWithName:(NSString *)name
                       value:(NSNumber *)value;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *value;

@end
