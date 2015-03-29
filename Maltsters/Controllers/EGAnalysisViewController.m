//
//  EGAnalysisViewController.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGAnalysisViewController.h"
#import "EGKMaltstersClient.h"
#import "EGLot.h"
#import "EGKAnalysisItem.h"
#import "EGKAnalysisItemCell.h"
#import "EGArrayDataSource.h"
#import "EGEmptyTableView.h"

NSString *const EGAnalysisViewControllerSegueIdentifier = @"EGAnalysisViewControllerSegueIdentifier";
NSString *const EGAnalysisViewControllerIdentifier = @"EGAnalysisViewControllerIdentifier";

@interface EGAnalysisViewController ()

@property (nonatomic, strong) EGArrayDataSource *source;
@property (nonatomic, strong) EGEmptyTableView *emptyView;

@end

@implementation EGAnalysisViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.title = self.lot.code;
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.emptyView = [EGEmptyTableView new];
    [self.emptyView addButtonTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

    self.source = [[EGArrayDataSource alloc] initWithCellIdentifier:EGAnalysisItemCellIdentifier
                                                 configureCellBlock:^(EGKAnalysisItemCell *cell, EGKAnalysisItem *item) {
                                                     [cell configureForAnalysisItem:item];
                                                 }];
    
    self.tableView.dataSource = self.source;
    self.tableView.backgroundView = self.emptyView;
    
    [self requestAnalysisItems];
}

- (void)requestAnalysisItems
{
    [self.emptyView setProgressMessage:@"Fetching Analysis"];
    [[EGKMaltstersClient sharedClient] fetchLotFromIdentifier:self.lot.identifier
                                        withCompletionBlock:^(EGLot *lot, NSError *error) {
                                            if (error) {
                                                [self loadError:error];
                                            }
                                            else {
                                                [self loadAnalysisItems:
                                                 [EGKAnalysisItem itemsWithAnalysis:lot.analysis]];
                                            }
                                            [self.refreshControl endRefreshing];
                                        }];
}

- (void)loadError:(NSError*)error
{
    [self.emptyView setErrorMessage:@"Can't find the Server"];
    [self.source removeAllItems];
    [self.tableView reloadData];
    self.tableView.backgroundView = self.emptyView;
}

- (void)loadAnalysisItems:(NSArray *)analysisItems
{
    [self.source removeAllItems];
    [self.source addItems:analysisItems withHeader:NSLocalizedString(@"Lot Analysis", nil)];
    self.tableView.backgroundView = nil;
    [self.tableView reloadData];
}

#pragma mark - Events

- (void)refresh:(id)sender
{
    [self requestAnalysisItems];
}

@end
