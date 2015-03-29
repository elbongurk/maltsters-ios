//
//  EGLotsViewController.m
//  Maltsters
//
//  Created by Ryan Krug on 2/25/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGLotsViewController.h"
#import "EGMalt.h"
#import "EGLot.h"
#import "EGLotCell.h"
#import "EGKMaltstersClient.h"
#import "EGArrayDataSource.h"
#import "EGAnalysisViewController.h"
#import "EGLotsSearchViewController.h"
#import "EGEmptyTableView.h"

NSString *const EGLotsViewControllerSegueIdentifier = @"EGLotsViewControllerSegueIdentifier";

@interface EGLotsViewController ()

@property (nonatomic, strong) EGLotsSearchViewController *searchResultsController;
@property (nonatomic, strong) UISearchController *search;
@property (nonatomic, strong) EGArrayDataSource *source;
@property (nonatomic, strong) EGEmptyTableView *emptyView;

@end

@implementation EGLotsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.emptyView = [EGEmptyTableView new];
    [self.emptyView addButtonTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    self.searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:EGLotsSearchViewControllerIdentifier];
    
    self.search = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.search.hidesNavigationBarDuringPresentation = YES;
    self.search.dimsBackgroundDuringPresentation = YES;
    self.search.searchResultsUpdater = self.searchResultsController;
    self.search.delegate = self;

    [self.search.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.search.searchBar;
    
    self.definesPresentationContext = YES;
    
    self.source = [[EGArrayDataSource alloc] initWithCellIdentifier:EGLotCellIdentifier
                                                 configureCellBlock:^(EGLotCell *cell, EGLot *item) {
                                                     [cell configureForLot:item];
                                                 }];

    self.tableView.dataSource = self.source;
    self.tableView.backgroundView = self.emptyView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestLots];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // pass this on to searchResultController in the event it has a tableViewCell to deselect
    if (self.search.isActive) {
        [self.searchResultsController viewWillAppear:animated];
    }
}

- (void)requestLots
{
    [self.emptyView setProgressMessage:@"Fetching Lots"];
    [[EGKMaltstersClient sharedClient] fetchMaltFromIdentifier:self.malt.identifier
                                         withCompletionBlock:^(EGMalt *malt, NSError *error) {
                                             if (error) {
                                                 [self loadError:error];
                                             }
                                             else {
                                                 [self loadLots:malt.lots];
                                             }
                                             [self.refreshControl endRefreshing];
                                         }];
}

- (void)loadError:(NSError *)error
{
    [self.emptyView setErrorMessage:@"Can't find the Server"];
    [self.source removeAllItems];
    [self.tableView reloadData];
    self.searchResultsController.lots = [NSArray array];
    self.tableView.backgroundView = self.emptyView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadLots:(NSArray *)lots
{
    [self.source removeAllItems];
    [self.source addItems:lots
          usingComparator:^NSComparisonResult(EGLot *lot1, EGLot *lot2) {
              NSInteger code1 = lot1.code.integerValue;
              NSInteger code2 = lot2.code.integerValue;
              if (code1 != 0 && code2 != 0) {
                  return code2 - code1;
              }
              else if (code1 != 0) {
                  return -1;
              }
              else if (code2 != 0) {
                  return 1;
              }
              return [lot1.code compare:lot2.code];
          }];
    
    self.searchResultsController.lots = [self.source itemsForSection:0];
    
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView reloadData];
}

#pragma mark - Events

- (void)refresh:(id)sender
{
    [self requestLots];
}

#pragma mark - UISearchControllerDelegate

- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.title = NSLocalizedString(@"Search", nil);
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    self.title = NSLocalizedString(@"Lots", nil);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EGAnalysisViewControllerSegueIdentifier]) {
        EGAnalysisViewController *vc = segue.destinationViewController;
        vc.lot = [self.source itemForIndexPath:self.tableView.indexPathForSelectedRow];
    }
}

@end
