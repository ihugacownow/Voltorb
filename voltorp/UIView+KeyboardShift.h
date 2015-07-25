//
//  UIView+KeyboardShift.h
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KeyboardShift)

@property (nonatomic, strong) NSNumber *lastViewBottomPadding;

- (void)registerForKeyboardShiftBoundByView:(UIView *)view;
- (void)unregisterForKeyboardShift;

@end
