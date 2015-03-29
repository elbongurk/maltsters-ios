//
//  EGKMaltstersClient.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKMaltstersClient.h"
#import "EGKMaltster.h"
#import "EGMalt.h"
#import "EGLot.h"

@implementation EGKMaltstersClient

+ (instancetype)sharedClient
{
    static EGKMaltstersClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:ROOT_URL];
        _sharedClient = [[EGKMaltstersClient alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)fetchMalstersWithCompletionBlock:(EGMalstersClientMalstersCompletionBlock)block
{
    return [self GET:@"maltsters.json"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *items;
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     items = [EGKMaltster itemsWithJSON:responseObject[@"maltsters"]];
                 }
                 block(items, nil);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 block(nil, error);
             }];
}

- (NSURLSessionDataTask *)fetchMalsterFromIdentifier:(NSNumber *)identifier
                                 withCompletionBlock:(EGMalstersClientMalsterCompletionBlock)block
{
    return [self GET:[NSString stringWithFormat:@"maltsters/%@.json", identifier]
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 EGKMaltster *malster;
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     malster = [[EGKMaltster alloc] initWithJSON:responseObject[@"maltster"]];
                 }
                 block(malster, nil);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 block(nil, error);
             }];
}

- (NSURLSessionDataTask *)fetchMaltFromIdentifier:(NSNumber *)identifier
                              withCompletionBlock:(EGMalstersClientMaltCompletionBlock)block
{
    return [self GET:[NSString stringWithFormat:@"malts/%@.json", identifier]
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 EGMalt *malt;
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     malt = [[EGMalt alloc] initWithJSON:responseObject[@"malt"]];
                 }
                 block(malt, nil);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 block(nil, error);
             }];
}

- (NSURLSessionDataTask *)fetchLotFromIdentifier:(NSNumber *)identifier
                             withCompletionBlock:(EGMalstersClientLotCompletionBlock)block
{
    return [self GET:[NSString stringWithFormat:@"lots/%@.json", identifier]
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 EGLot *lot;
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     lot = [[EGLot alloc] initWithJSON:responseObject[@"lot"]];
                 }
                 block(lot, nil);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 block(nil, error);
             }];
}


@end
