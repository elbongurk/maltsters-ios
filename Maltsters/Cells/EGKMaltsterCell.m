//
//  EGKMaltsterCell.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKMaltsterCell.h"
#import "EGKMaltster.h"

#import <QuartzCore/QuartzCore.h>

NSString *const EGKMaltsterCellIdentifier = @"EGMalsterCellIdentifier";

@implementation EGKMaltsterCell

- (void)configureForMalster:(EGKMaltster *)malster
{
    self.nameLabel.text = malster.name;
}

@end
