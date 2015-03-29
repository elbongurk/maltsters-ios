//
//  EGKAppDelegate.m
//  Maltsters
//
//  Created by Ryan Krug on 3/29/15
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKAppDelegate.h"

@implementation EGKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIColor *brandGreen = [UIColor colorWithRed:0.0f green:232/255.0f blue:195/255.0f alpha:1.0f];
    UIColor *brandWhite = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setBarTintColor:brandGreen];
    [[UINavigationBar appearance] setTintColor:brandWhite];
    
    NSDictionary *titleText = @{ NSForegroundColorAttributeName: brandWhite,
                                 NSFontAttributeName: [UIFont fontWithName:@"Clear Sans Light" size:20.0f]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleText];
    
    NSDictionary *backText = @{ NSForegroundColorAttributeName: brandWhite,
                                NSFontAttributeName: [UIFont fontWithName:@"Clear Sans" size:16.0f]};
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:backText
                                                                                            forState:UIControlStateNormal];
    
    UIFont *headerFont = [UIFont fontWithName:@"Clear Sans Light" size:14];
    
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:headerFont];
    
    NSDictionary *searchText = @{ NSFontAttributeName: [UIFont fontWithName:@"Clear Sans Light" size:16.0f]};
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:searchText];
    
    return YES;
}

@end
