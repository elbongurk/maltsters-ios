//
//  EGAnalysis.m
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGAnalysis.h"

@implementation EGAnalysis

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    id value;
    
    value = JSONDictionary[@"name"];
    if (value && value != [NSNull null]) {
        _name = value;
    }
    value = JSONDictionary[@"moisture"];
    if (value && value != [NSNull null]) {
        _moisture = @([value floatValue]);
    }
    value = JSONDictionary[@"fine_grind_as_is"];
    if (value && value != [NSNull null]) {
        _fineGrindAsIs = @([value floatValue]);
    }
    value = JSONDictionary[@"fine_grind_dry_basis"];
    if (value && value != [NSNull null]) {
        _fineGrindDryBasis = @([value floatValue]);
    }
    value = JSONDictionary[@"coarse_grind_as_is"];
    if (value && value != [NSNull null]) {
        _coarseGrindAsIs = @([value floatValue]);
    }
    value = JSONDictionary[@"coarse_grind_dry_basis"];
    if (value && value != [NSNull null]) {
        _coarseGrindDryBasis = @([value floatValue]);
    }
    value = JSONDictionary[@"fine_coarse_grind_diff"];
    if (value && value != [NSNull null]) {
        _fineCoarseGrindDiff = @([value floatValue]);
    }
    value = JSONDictionary[@"lovibond"];
    if (value && value != [NSNull null]) {
        _lovibond = @([value floatValue]);
    }
    value = JSONDictionary[@"diastatic_power"];
    if (value && value != [NSNull null]) {
        _diastaticPower = @([value floatValue]);
    }
    value = JSONDictionary[@"alpha_amylase"];
    if (value && value != [NSNull null]) {
        _alphaAmylase = @([value floatValue]);
    }
    value = JSONDictionary[@"total_protein"];
    if (value && value != [NSNull null]) {
        _totalProtein = @([value floatValue]);
    }
    value = JSONDictionary[@"soluble_nitrogen"];
    if (value && value != [NSNull null]) {
        _solubleNitrogen = @([value floatValue]);
    }
    value = JSONDictionary[@"viscosity"];
    if (value && value != [NSNull null]) {
        _viscosity = @([value floatValue]);
    }
    value = JSONDictionary[@"beta_glucan"];
    if (value && value != [NSNull null]) {
        _betaGlucan = @([value floatValue]);
    }
    value = JSONDictionary[@"assortment_1"];
    if (value && value != [NSNull null]) {
        _assortment1 = @([value floatValue]);
    }
    value = JSONDictionary[@"assortment_2"];
    if (value && value != [NSNull null]) {
        _assortment2 = @([value floatValue]);
    }
    value = JSONDictionary[@"assortment_thru"];
    if (value && value != [NSNull null]) {
        _assortmentThru = @([value floatValue]);
    }
 
    return self;
}

@end
