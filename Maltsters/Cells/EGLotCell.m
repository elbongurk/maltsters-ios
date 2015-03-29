//
//  EGLotCell.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGLotCell.h"
#import "EGLot.h"

NSString *const EGLotCellIdentifier = @"EGLotCellIdentifier";

@implementation EGLotCell

- (void)configureForLot:(EGLot *)lot
{
    self.codeLabel.text = lot.code;
}

@end
