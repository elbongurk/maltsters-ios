//
//  EGMaltsViewController.h
//  Maltsters
//
//  Created by Ryan Krug on 2/25/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGMaltsViewControllerSegueIdentifier;

@class EGKMaltster;

@interface EGMaltsViewController : UITableViewController

@property (nonatomic, strong) EGKMaltster *malster;

@end
