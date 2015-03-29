//
//  EGKMaltstersClient.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class EGKMaltster;
@class EGMalt;
@class EGLot;

typedef void(^EGMalstersClientMalstersCompletionBlock)(NSArray *malsters, NSError *error);
typedef void(^EGMalstersClientMalsterCompletionBlock)(EGKMaltster *malster, NSError *error);
typedef void(^EGMalstersClientMaltCompletionBlock)(EGMalt *malt, NSError *error);
typedef void(^EGMalstersClientLotCompletionBlock)(EGLot *lot, NSError *error);

@interface EGKMaltstersClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)fetchMalstersWithCompletionBlock:(EGMalstersClientMalstersCompletionBlock)block;

- (NSURLSessionDataTask *)fetchMalsterFromIdentifier:(NSNumber *)identifier
                              withCompletionBlock:(EGMalstersClientMalsterCompletionBlock)block;

- (NSURLSessionDataTask *)fetchMaltFromIdentifier:(NSNumber *)identifier
                                 withCompletionBlock:(EGMalstersClientMaltCompletionBlock)block;

- (NSURLSessionDataTask *)fetchLotFromIdentifier:(NSNumber *)identifier
                                 withCompletionBlock:(EGMalstersClientLotCompletionBlock)block;


@end
