//
//  EGKAppearanceManager.m
//  Maltsters
//
//  Created by Ryan Krug on 3/29/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKAppearanceManager.h"

@implementation EGKAppearanceManager

+ (instancetype)sharedManager
{
    static EGKAppearanceManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [EGKAppearanceManager new];
    });
    
    return _sharedManager;
}

- (UIColor *)brandGreen
{
    return [UIColor colorWithRed:0.0f green:232/255.0f blue:195/255.0f alpha:1.0f];
}

- (UIColor *)brandWhite
{
    return [UIColor whiteColor];
}

- (void)setupAppearanceOptions
{
    [self setupNavigationBar];
    [self setupTableView];
    [self setupSearchBar];
}

- (void)setupNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:self.brandGreen];
    [[UINavigationBar appearance] setTintColor:self.brandWhite];
    
    NSDictionary *titleText = @{ NSForegroundColorAttributeName: self.brandWhite,
                                 NSFontAttributeName: [UIFont fontWithName:@"Clear Sans" size:18.0f]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleText];
    
    NSDictionary *backText = @{ NSForegroundColorAttributeName: self.brandWhite,
                                NSFontAttributeName: [UIFont fontWithName:@"Clear Sans Light" size:18.0f]};
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:backText
                                                                                            forState:UIControlStateNormal];
}

- (void)setupTableView
{
    UIFont *headerFont = [UIFont fontWithName:@"Clear Sans Light" size:14];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:headerFont];
}

- (void)setupSearchBar
{
    NSDictionary *searchText = @{ NSFontAttributeName: [UIFont fontWithName:@"Clear Sans Light" size:16.0f]};
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:searchText];
    [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitleColor:self.brandWhite forState:UIControlStateNormal];
}

@end
