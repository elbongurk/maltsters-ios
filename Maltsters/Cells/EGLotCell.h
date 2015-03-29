//
//  EGLotCell.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGLotCellIdentifier;

@class EGLot;

@interface EGLotCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *codeLabel;

- (void)configureForLot:(EGLot *)lot;

@end
