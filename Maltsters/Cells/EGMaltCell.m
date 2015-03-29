//
//  EGMaltCell.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGMaltCell.h"
#import "EGMalt.h"

NSString *const EGMaltCellIdentifier = @"EGMaltCellIdentifier";


@implementation EGMaltCell

- (void)configureForMalt:(EGMalt *)malt
{
//    var r=0, g=0, b=0;
//    
//    if (lovibond < 1.7) {
//        r = 226.6017;
//        g = 174.7456;
//        b = 101.7924;
//    } else if (lovibond > 600) {
//        r = 76.52;
//        g = 58.344;
//        b = 47.936;
//    } else {
//        r = 227.3 - 0.4112*lovibond + 0.0002665*lovibond*lovibond;
//        g = 175.5 - 0.4445*lovibond + 0.0004154*lovibond*lovibond;
//        b = 102.2 - 0.2402*lovibond + 0.0002496*lovibond*lovibond;
//    }
    
    self.nameLabel.text = malt.name;
}

@end
