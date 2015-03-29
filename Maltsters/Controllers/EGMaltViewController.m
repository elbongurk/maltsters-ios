//
//  EGMaltViewController.m
//  Maltsters
//
//  Created by Ryan Krug on 3/20/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGMaltViewController.h"
#import "EGArrayDataSource.h"
#import "EGKMaltstersClient.h"
#import "EGMalt.h"
#import "EGKAnalysisItem.h"
#import "EGKAnalysisItemCell.h"
#import "EGLotsViewController.h"
#import "EGEmptyTableView.h"

NSString *const EGMaltViewControllerSegueIdentifier = @"EGMaltViewControllerSegueIdentifier";

@interface EGMaltViewController ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) EGEmptyTableView *emptyView;

@end

@implementation EGMaltViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.malt.name;

    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.emptyView = [EGEmptyTableView new];
    [self.emptyView addButtonTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    self.items = [NSArray array];
    self.tableView.backgroundView = self.emptyView;
    
    [self requestAnalysisItems];
}

- (void)requestAnalysisItems
{
    [self.emptyView setProgressMessage:@"Fetching Analysis"];
    [[EGKMaltstersClient sharedClient] fetchMaltFromIdentifier:self.malt.identifier
                                         withCompletionBlock:^(EGMalt *malt, NSError *error) {
                                             if (error) {
                                                 [self loadError:error];
                                             }
                                             else {
                                                 [self loadAnalysisItems:
                                                  [EGKAnalysisItem itemsWithAnalysis:malt.analysis]];
                                             }
                                             [self.refreshControl endRefreshing];
                                         }];
    
}

- (void)loadError:(NSError *)error
{
    [self.emptyView setErrorMessage:@"Can't find the Server"];
    self.items = [NSArray array];
    [self.tableView reloadData];
    self.tableView.backgroundView = self.emptyView;
}

- (void)loadAnalysisItems:(NSArray *)items
{
    self.items = items;
    self.tableView.backgroundView = nil;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Events

- (void)refresh:(id)sender
{
    [self requestAnalysisItems];
}

#pragma mark - UITableViewDataSource Helpers

- (UITableViewCell *)cellForLotsRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"EGLotsCellIdentifier"
                                                                 forIndexPath:indexPath];
    
    return cell;
}

- (UITableViewCell *)cellForMetaAnalysisItemRowAtIndexPath:(NSIndexPath *)indexPath
{
    EGKAnalysisItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:EGAnalysisItemCellIdentifier
                                                                    forIndexPath:indexPath];
    
    [cell configureForAnalysisItem:self.items[(NSUInteger)indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return nil;
        case 1:
            return self.items.count > 0 ? NSLocalizedString(@"Malt Analysis", nil) : nil;
        default:
            return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return (NSInteger)self.items.count;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self cellForLotsRowAtIndexPath:indexPath];
        case 1:
            return [self cellForMetaAnalysisItemRowAtIndexPath:indexPath];
        default:
            return nil;
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EGLotsViewControllerSegueIdentifier]) {
        EGLotsViewController *vc = segue.destinationViewController;
        vc.malt = self.malt;
    }
}

@end
