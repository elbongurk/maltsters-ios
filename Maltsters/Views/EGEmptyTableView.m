//
//  EGEmptyTableView.m
//  Maltsters
//
//  Created by Ryan Krug on 3/28/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import "EGEmptyTableView.h"

@interface EGEmptyTableView()

@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation EGEmptyTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (!self) {
        return nil;
    }
    
    [self setInitialValues];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    [self setInitialValues];
    
    return self;
}

- (void)setInitialValues
{
    [self setupNib];
    [self setupCustomConstraints];
    [self setupContainerView];
    [self setupRefreshButton];
}

- (void)setupNib
{
    [[NSBundle mainBundle] loadNibNamed:@"EmptyTableView" owner:self options:nil];
}

- (void)setupCustomConstraints
{
    _customConstraints = [NSMutableArray new];
}

- (void)setupContainerView
{
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_containerView];
    [self setNeedsUpdateConstraints];
}

- (void)setupRefreshButton
{
    UIColor *brandGreen = [UIColor colorWithRed:0.0f green:232/255.0f blue:195/255.0f alpha:1.0f];
    _refreshButton.layer.borderWidth = 2.0f;
    _refreshButton.layer.borderColor = brandGreen.CGColor;
}

- (void)updateConstraints
{
    [self removeConstraints:self.customConstraints];
    [self.customConstraints removeAllObjects];
    
    UIView *view = self.containerView;
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    
    [self.customConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:
      @"H:|-0-[view]-0-|" options:0 metrics:nil views:views]];
    [self.customConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:
      @"V:|-0-[view]-0-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:self.customConstraints];
    
    [super updateConstraints];
}

- (void)setErrorMessage:(NSString *)message;
{
    self.statusImage.image = [UIImage imageNamed:@"emoji-sad"];
    self.messageLabel.text = message;
    self.refreshButton.hidden = NO;
    
    [self.activityView stopAnimating];
}

- (void)setProgressMessage:(NSString *)message;
{
    self.statusImage.image = [UIImage imageNamed:@"maltsters"];
    self.messageLabel.text = message;
    self.refreshButton.hidden = YES;
    
    [self.activityView startAnimating];
}

- (void)addButtonTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.refreshButton addTarget:target action:action forControlEvents:controlEvents];
}
- (void)removeButtonTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.refreshButton removeTarget:target action:action forControlEvents:controlEvents];
}


@end
