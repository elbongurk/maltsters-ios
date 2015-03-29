//
//  EGLotsViewController.h
//  Maltsters
//
//  Created by Ryan Krug on 2/25/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGLotsViewControllerSegueIdentifier;

@class EGMalt;

@interface EGLotsViewController : UITableViewController<UISearchControllerDelegate>

@property (nonatomic, strong) EGMalt *malt;

@end
