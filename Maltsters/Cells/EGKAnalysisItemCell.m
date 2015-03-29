//
//  EGKAnalysisItemCell.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKAnalysisItemCell.h"
#import "EGKAnalysisItem.h"

NSString *const EGAnalysisItemCellIdentifier = @"EGAnalysisItemCellIdentifier";

@implementation EGKAnalysisItemCell

- (void)configureForAnalysisItem:(EGKAnalysisItem *)analysisItem
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    
    self.nameLabel.text = analysisItem.name;
    self.valueLabel.text = [formatter stringFromNumber:analysisItem.value];
}

@end
