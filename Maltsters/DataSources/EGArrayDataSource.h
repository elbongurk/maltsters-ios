//
//  EGArrayDataSource.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(id cell, id item);

@interface EGArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(CellConfigureBlock)aConfigureCellBlock;

- (void)removeAllItems;
- (NSArray *)itemsForSection:(NSInteger)section;
- (void)addItems:(NSArray *)items;
- (void)addItems:(NSArray *)items usingComparator:(NSComparator)comparator;
- (void)addItems:(NSArray *)items withHeader:(NSString *)header;
- (void)addItems:(NSArray *)items withHeader:(NSString *)header usingComparator:(NSComparator)comparator;
- (id)itemForIndexPath:(NSIndexPath *)path;

@end
