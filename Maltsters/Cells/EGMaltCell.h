//
//  EGMaltCell.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGMaltCellIdentifier;

@class EGMalt;

@interface EGMaltCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

- (void)configureForMalt:(EGMalt *)malt;

@end
