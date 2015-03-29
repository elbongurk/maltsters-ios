//
//  EGMaltViewController.h
//  Maltsters
//
//  Created by Ryan Krug on 3/20/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGMaltViewControllerSegueIdentifier;

@class EGMalt;

@interface EGMaltViewController : UITableViewController

@property (nonatomic, strong) EGMalt *malt;

@end
