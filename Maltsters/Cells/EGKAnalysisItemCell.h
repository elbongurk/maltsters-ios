//
//  EGKAnalysisItemCell.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGAnalysisItemCellIdentifier;

@class EGKAnalysisItem;

@interface EGKAnalysisItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;

- (void)configureForAnalysisItem:(EGKAnalysisItem *)analysisItem;

@end
