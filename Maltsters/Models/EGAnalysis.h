//
//  EGAnalysis.h
//  Maltsters
//
//  Created by Ryan Krug on 3/8/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGLot;

@interface EGAnalysis : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *moisture;
@property (nonatomic, strong) NSNumber *fineGrindAsIs;
@property (nonatomic, strong) NSNumber *fineGrindDryBasis;
@property (nonatomic, strong) NSNumber *coarseGrindAsIs;
@property (nonatomic, strong) NSNumber *coarseGrindDryBasis;
@property (nonatomic, strong) NSNumber *fineCoarseGrindDiff;
@property (nonatomic, strong) NSNumber *lovibond;
@property (nonatomic, strong) NSNumber *diastaticPower;
@property (nonatomic, strong) NSNumber *alphaAmylase;
@property (nonatomic, strong) NSNumber *totalProtein;
@property (nonatomic, strong) NSNumber *solubleNitrogen;
@property (nonatomic, strong) NSNumber *viscosity;
@property (nonatomic, strong) NSNumber *betaGlucan;
@property (nonatomic, strong) NSNumber *assortment1;
@property (nonatomic, strong) NSNumber *assortment2;
@property (nonatomic, strong) NSNumber *assortmentThru;

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;

@end
