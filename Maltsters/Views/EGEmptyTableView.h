//
//  EGEmptyTableView.h
//  Maltsters
//
//  Created by Ryan Krug on 3/28/15.
//  Copyright (c) 2015 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGEmptyTableView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *statusImage;
@property (nonatomic, weak) IBOutlet UILabel* messageLabel;
@property (nonatomic, weak) IBOutlet UIButton* refreshButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, weak) IBOutlet UIView *containerView;

- (void)setErrorMessage:(NSString *)message;
- (void)setProgressMessage:(NSString *)message;

- (void)addButtonTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)removeButtonTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
