//
//  EGArrayDataSource.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGArrayDataSource.h"

@interface EGArrayDataSource ()

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableArray *headers;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;

@end

@implementation EGArrayDataSource

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(CellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _sections = [NSMutableArray array];
    _headers = [NSMutableArray array];
    _cellIdentifier = aCellIdentifier;
    _configureCellBlock = aConfigureCellBlock;
    
    return self;
}

- (id)itemForIndexPath:(NSIndexPath *)path
{
    return self.sections[(NSUInteger)path.section][(NSUInteger)path.item];
}

- (NSArray *)itemsForSection:(NSInteger)section
{
    return self.sections[(NSUInteger)section];
}

- (void)removeAllItems
{
    [self.headers removeAllObjects];
    [self.sections removeAllObjects];
}

- (void)addItems:(NSArray *)items
{
    [self addItems:items withHeader:nil];
}

- (void)addItems:(NSArray *)items usingComparator:(NSComparator)comparator
{
    [self addItems:items withHeader:nil usingComparator:comparator];
}

- (void)addItems:(NSArray *)items withHeader:(NSString *)header
{
    [self.sections addObject:items];
    if (!header) {
        [self.headers addObject:[NSNull null]];
    }
    else {
        [self.headers addObject:header];
    }
}

- (void)addItems:(NSArray *)items withHeader:(NSString *)header usingComparator:(NSComparator)comparator
{
    NSMutableArray *sortedItems = [NSMutableArray arrayWithCapacity:items.count];
    
    for (id object in items) {
        NSUInteger index = [sortedItems indexOfObject:object
                                        inSortedRange:NSMakeRange(0, sortedItems.count)
                                              options:NSBinarySearchingInsertionIndex
                                      usingComparator:comparator];
        [sortedItems insertObject:object atIndex:index];
    }
    
    [self addItems:sortedItems withHeader:header];
}


#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id value = self.headers[(NSUInteger)section];
    
    if (value == [NSNull null]) {
        return nil;
    }
    
    return value;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (NSInteger)self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = self.sections[(NSUInteger)section];
    return (NSInteger)items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (NSInteger)self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *items = self.sections[(NSUInteger)section];
    return (NSInteger)items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier
                                                                           forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}


@end
