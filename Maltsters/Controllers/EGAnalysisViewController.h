//
//  EGAnalysisViewController.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGAnalysisViewControllerSegueIdentifier;
extern NSString *const EGAnalysisViewControllerIdentifier;

@class EGLot;

@interface EGAnalysisViewController : UITableViewController

@property (nonatomic, strong) EGLot *lot;

@end
