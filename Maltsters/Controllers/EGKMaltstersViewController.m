//
//  EGKMaltstersViewController.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKMaltstersViewController.h"
#import "EGKMaltster.h"
#import "EGKMaltsterCell.h"
#import "EGArrayDataSource.h"
#import "EGKMaltstersClient.h"
#import "EGMaltsViewController.h"
#import "EGEmptyTableView.h"

@interface EGKMaltstersViewController()

@property (nonatomic, strong) EGArrayDataSource *source;
@property (nonatomic, strong) EGEmptyTableView *emptyView;

@end

@implementation EGKMaltstersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.emptyView = [EGEmptyTableView new];
    [self.emptyView addButtonTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    self.source = [[EGArrayDataSource alloc] initWithCellIdentifier:EGKMaltsterCellIdentifier
                                                 configureCellBlock:^(EGKMaltsterCell* cell, EGKMaltster* item) {
                                                     [cell configureForMalster:item];
                                                 }];
    
    self.tableView.dataSource = self.source;
    self.tableView.backgroundView = self.emptyView;

    [self requestMalsters];
}

- (void)requestMalsters
{
    [self.emptyView setProgressMessage:@"Finding Maltsters"];
    [[EGKMaltstersClient sharedClient] fetchMalstersWithCompletionBlock:^(NSArray *malsters, NSError *error) {
        if (error) {
            [self loadError:error];
        }
        else {
            [self loadMalsters:malsters];
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

- (void)loadMalsters:(NSArray *)malsters
{
    [self.source removeAllItems];
    [self.source addItems:malsters usingComparator:^NSComparisonResult(EGKMaltster *malster1, EGKMaltster *malster2) {
        return [malster1.name compare:malster2.name];
    }];
    self.tableView.backgroundView = nil;
    [self.tableView reloadData];
}

#pragma mark - Events

- (void)refresh:(id)sender
{    
    [self requestMalsters];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EGMaltsViewControllerSegueIdentifier]) {
        EGMaltsViewController *vc = (EGMaltsViewController *)segue.destinationViewController;
        vc.malster = [self.source itemForIndexPath:self.tableView.indexPathForSelectedRow];
    }
}


@end
