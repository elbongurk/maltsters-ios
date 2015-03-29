//
//  EGLotsSearchViewController.m
//  Maltsters
//
//  Created by Ryan Krug on 3/25/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGLotsSearchViewController.h"
#import "EGArrayDataSource.h"
#import "EGLotCell.h"
#import "EGLot.h"
#import "EGAnalysisViewController.h"

NSString *const EGLotsSearchViewControllerIdentifier = @"EGLotsSearchViewControllerIdentifier";

@interface EGLotsSearchViewController ()

@property (nonatomic, strong) EGArrayDataSource *source;

@end

@implementation EGLotsSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.source = [[EGArrayDataSource alloc] initWithCellIdentifier:EGLotCellIdentifier
                                                 configureCellBlock:^(EGLotCell *cell, EGLot *item) {
                                                     [cell configureForLot:item];
                                                 }];
    
    self.tableView.dataSource = self.source;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.code contains[c] %@", searchText];
    
    [self.source removeAllItems];
    [self.source addItems:[self.lots filteredArrayUsingPredicate:predicate]];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EGAnalysisViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:EGAnalysisViewControllerIdentifier];
    
    vc.lot = [self.source itemForIndexPath:indexPath];

    if (self.navigationController) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (self.presentingViewController.navigationController) {
        [self.presentingViewController.navigationController pushViewController:vc animated:YES];
    }
}


@end
