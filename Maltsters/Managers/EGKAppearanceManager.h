//
//  EGKAppearanceManager.h
//  Maltsters
//
//  Created by Ryan Krug on 3/29/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGKAppearanceManager : NSObject

+ (instancetype)sharedManager;

- (UIColor *)brandGreen;
- (UIColor *)brandWhite;

- (void)setupAppearanceOptions;

@end
