//
//  EGMaltsViewController.m
//  Maltsters
//
//  Created by Ryan Krug on 2/25/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGMaltsViewController.h"
#import "EGMaltViewController.h"
#import "EGMalt.h"
#import "EGKMaltster.h"
#import "EGMaltCell.h"
#import "EGKMaltstersClient.h"
#import "EGArrayDataSource.h"
#import "EGEmptyTableView.h"

NSString *const EGMaltsViewControllerSegueIdentifier = @"EGMaltsViewControllerSegueIdentifier";

@interface EGMaltsViewController ()

@property (nonatomic, strong) EGArrayDataSource *source;
@property (nonatomic, strong) EGEmptyTableView *emptyView;

@end

@implementation EGMaltsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.malster.name;
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.emptyView = [EGEmptyTableView new];
    [self.emptyView addButtonTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

    self.source = [[EGArrayDataSource alloc] initWithCellIdentifier:EGMaltCellIdentifier
                                                 configureCellBlock:^(EGMaltCell* cell, EGMalt* item) {
                                                     [cell configureForMalt:item];
                                                 }];
    self.tableView.dataSource = self.source;
    self.tableView.backgroundView = self.emptyView;
    
    [self requestMalts];
}

- (void)requestMalts
{
    [self.emptyView setProgressMessage:@"Fetching Malts"];
    [[EGKMaltstersClient sharedClient] fetchMalsterFromIdentifier:self.malster.identifier
                                            withCompletionBlock:^(EGKMaltster *malster, NSError *error) {
                                                if (error) {
                                                    [self loadError:error];
                                                }
                                                else {
                                                    [self loadMalts:malster.malts];
                                                }
                                                [self.refreshControl endRefreshing];
                                            }];
}

- (void)loadError:(NSError *)error
{
    [self.emptyView setErrorMessage:@"Can't find the Server"];
    [self.source removeAllItems];
    [self.tableView reloadData];
    self.tableView.backgroundView = self.emptyView;
}

- (void)loadMalts:(NSArray *)malts
{
    NSMutableArray *baseMalts = [NSMutableArray array];
    NSMutableArray *crystalMalts = [NSMutableArray array];
    NSMutableArray *roastedMalts = [NSMutableArray array];
    NSMutableArray *bodyMalts = [NSMutableArray array];
    NSMutableArray *specialtyMalts = [NSMutableArray array];
    NSMutableArray *otherMalts = [NSMutableArray array];
    
    NSComparator comparator = ^NSComparisonResult(EGMalt *malt1, EGMalt *malt2) {
        return [malt1.name compare:malt2.name];
    };
    
    for (EGMalt *malt in malts) {
        NSMutableArray *array;
        
        if ([malt.type isEqualToString:@"base"]) {
            array = baseMalts;
        }
        else if ([malt.type isEqualToString:@"crystal"]) {
            array = crystalMalts;
        }
        else if ([malt.type isEqualToString:@"roasted"]) {
            array = roastedMalts;
        }
        else if ([malt.type isEqualToString:@"body"]) {
            array = bodyMalts;
        }
        else if ([malt.type isEqualToString:@"specialty"]) {
            array = specialtyMalts;
        }
        else {
            array = otherMalts;
        }
        
        NSUInteger index = [array indexOfObject:malt
                                  inSortedRange:NSMakeRange(0, array.count)
                                        options:NSBinarySearchingInsertionIndex
                                usingComparator:comparator];
        [array insertObject:malt atIndex:index];
    }
    
    [self.source removeAllItems];
    
    if (baseMalts.count > 0) {
        [self.source addItems:baseMalts withHeader:NSLocalizedString(@"Base Malts", nil)];
    }
    if (crystalMalts.count > 0) {
        [self.source addItems:crystalMalts withHeader:NSLocalizedString(@"Crystal Malts", nil)];
    }
    if (roastedMalts.count > 0) {
        [self.source addItems:roastedMalts withHeader:NSLocalizedString(@"Roasted Malts", nil)];
    }
    if (bodyMalts.count > 0) {
        [self.source addItems:bodyMalts withHeader:NSLocalizedString(@"Body Malts", nil)];
    }
    if (specialtyMalts.count > 0) {
        [self.source addItems:specialtyMalts withHeader:NSLocalizedString(@"Specialty Malts", nil)];
    }
    if (otherMalts.count > 0) {
        [self.source addItems:otherMalts withHeader:NSLocalizedString(@"Other Malts", nil)];
    }
    
    self.tableView.backgroundView = nil;
    [self.tableView reloadData];
}

#pragma mark - Events

- (void)refresh:(id)sender
{
    [self requestMalts];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EGMaltViewControllerSegueIdentifier]) {
        EGMaltViewController *vc = segue.destinationViewController;
        vc.malt = [self.source itemForIndexPath:self.tableView.indexPathForSelectedRow];
    }
}

@end
