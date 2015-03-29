//
//  EGKAppDelegate.m
//  Maltsters
//
//  Created by Ryan Krug on 3/29/15
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKAppDelegate.h"
#import "EGKAppearanceManager.h"

@implementation EGKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[EGKAppearanceManager sharedManager] setupAppearanceOptions];
    
    return YES;
}

@end
