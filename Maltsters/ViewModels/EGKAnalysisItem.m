//
//  EGKAnalysisItem.m
//  Maltsters
//
//  Created by Ryan Krug on 3/10/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGKAnalysisItem.h"
#import "EGAnalysis.h"
#import "EGLot.h"
#import "EGMalt.h"

@implementation EGKAnalysisItem

+ (NSArray *)itemsWithAnalysis:(EGAnalysis *)analysis
{
    NSMutableArray *array = [NSMutableArray array];
    
    if (analysis.moisture) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Moisture", nil)
                                                        value:analysis.moisture]];
    }
    if (analysis.fineGrindAsIs) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Fine Grind, As-Is", nil)
                                                        value:analysis.fineGrindAsIs]];
    }
    if (analysis.fineGrindDryBasis) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Fine Grind, Dry Basis", nil)
                                                        value:analysis.fineGrindDryBasis]];
    }
    if (analysis.coarseGrindAsIs) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Coarse Grind, As-Is", nil)
                                                        value:analysis.coarseGrindAsIs]];
    }
    if (analysis.coarseGrindDryBasis) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Coarse Grind, Dry Basis", nil)
                                                        value:analysis.coarseGrindDryBasis]];
    }
    if (analysis.fineCoarseGrindDiff) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Fine / Coarse Grind Difference", nil)
                                                        value:analysis.fineCoarseGrindDiff]];
    }
    if (analysis.lovibond) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Lovibond", nil)
                                                        value:analysis.lovibond]];
    }
    if (analysis.diastaticPower) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Diastatic Power", nil)
                                                        value:analysis.diastaticPower]];
    }
    if (analysis.alphaAmylase) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Alpha Amylase", nil)
                                                        value:analysis.alphaAmylase]];
    }
    if (analysis.totalProtein) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Total Protein", nil)
                                                        value:analysis.totalProtein]];
    }
    if (analysis.solubleNitrogen) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Soluble Nitrogen", nil)
                                                        value:analysis.solubleNitrogen]];
    }
    if (analysis.viscosity) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Viscosity", nil)
                                                        value:analysis.viscosity]];
    }
    if (analysis.betaGlucan) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Beta Glucan", nil)
                                                        value:analysis.betaGlucan]];
    }
    if (analysis.assortment1) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Assortment 7/64", nil)
                                                        value:analysis.assortment1]];
    }
    if (analysis.assortment2) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Assortment 6/64", nil)
                                                        value:analysis.assortment2]];
    }
    if (analysis.assortmentThru) {
        [array addObject:[[EGKAnalysisItem alloc] initWithName:NSLocalizedString(@"Assortment Thru", nil)
                                                        value:analysis.assortmentThru]];
    }
    
    return  array;
}

- (instancetype)initWithName:(NSString *)name
                       value:(NSNumber *)value
{
    self = [super init];

    if (!self) {
        return nil;
    }
    
    _name = name;
    _value = value;
    
    return self;
}


@end
