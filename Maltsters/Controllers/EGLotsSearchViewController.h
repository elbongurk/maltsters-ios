//
//  EGLotsSearchViewController.h
//  Maltsters
//
//  Created by Ryan Krug on 3/25/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGLotsSearchViewControllerIdentifier;

@interface EGLotsSearchViewController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *lots;

@end
