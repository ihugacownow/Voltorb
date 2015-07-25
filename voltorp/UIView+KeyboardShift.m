//
//  UIView+KeyboardShift.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "UIView+KeyboardShift.h"
#import <objc/runtime.h>

static char GCViewToKeepAboveKeyboardIdentifier;
static char GCHasShiftedViewForKeyboardIdentifier;

static CGFloat kLastViewKeyboardPadding = 11;

@implementation UIView (KeyboardShift)


- (NSNumber *)lastViewBottomPadding
{
    return objc_getAssociatedObject(self, @selector(lastViewBottomPadding));
}

- (void)setLastViewBottomPadding:(NSNumber *)lastViewBottomPadding
{
    objc_setAssociatedObject(self, @selector(lastViewBottomPadding), lastViewBottomPadding, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setViewToKeepAboveKeyboard:(UIView *)view
{
    objc_setAssociatedObject(self, &GCViewToKeepAboveKeyboardIdentifier, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)viewToKeepAboveKeyboard
{
    return objc_getAssociatedObject(self, &GCViewToKeepAboveKeyboardIdentifier);
}

- (void)setHasShiftedViewForKeyboard:(BOOL)shifted
{
    objc_setAssociatedObject(self, &GCHasShiftedViewForKeyboardIdentifier, @(shifted), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hasShiftedViewForKeyboard
{
    return [objc_getAssociatedObject(self, &GCHasShiftedViewForKeyboardIdentifier)  boolValue];
}

- (void)registerForKeyboardShiftBoundByView:(UIView *)view
{
    [self setViewToKeepAboveKeyboard:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GCView_keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GCView_keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unregisterForKeyboardShift
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)GCView_keyboardWillShow:(NSNotification *)notification
{
    
    //Shift View upwards so self.viewToKeepAboveKeyboard is visible
    CGFloat padding = self.lastViewBottomPadding? [self.lastViewBottomPadding doubleValue] : kLastViewKeyboardPadding;
    CGFloat maxY = CGRectGetMaxY(self.viewToKeepAboveKeyboard.frame) + padding;
    
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *animation = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curveInfo = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect keyboardBoundsRaw = [value CGRectValue];
    CGRect keyboardBounds = [[UIApplication sharedApplication].keyWindow convertRect:keyboardBoundsRaw toView:self];
    
    CGFloat animationDuration = [animation floatValue];
    UIViewAnimationOptions animationOption = [curveInfo intValue] << 16;
    
    CGFloat availableSpace = self.bounds.size.height - maxY;
    CGFloat shiftYOffset = keyboardBounds.size.height - availableSpace;
    
    if (shiftYOffset > 0) {
        
        self.hasShiftedViewForKeyboard = YES;
        
        CGRect finalViewBounds = self.bounds;
        finalViewBounds.origin.y = shiftYOffset;
        
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:animationOption|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.bounds = finalViewBounds;
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }
}

- (void)GCView_keyboardWillHide:(NSNotification *)notification
{
    if (!self.hasShiftedViewForKeyboard) {
        return;
    }
    
    CGFloat maxY = CGRectGetMaxY(self.viewToKeepAboveKeyboard.frame);
    
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *animation = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curveInfo = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect keyboardBoundsRaw = [value CGRectValue];
    CGRect keyboardBounds = [[UIApplication sharedApplication].keyWindow convertRect:keyboardBoundsRaw toView:self];
    
    CGFloat animationDuration = [animation floatValue];
    UIViewAnimationOptions animationOption = [curveInfo intValue] << 16;
    
    CGFloat availableSpace = self.bounds.size.height - maxY;
    CGFloat shiftYOffset = keyboardBounds.size.height - availableSpace;
    
    if (shiftYOffset > 0) {
        
        CGRect finalViewBounds = self.bounds;
        finalViewBounds.origin.y = 0;
        
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:animationOption|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.bounds = finalViewBounds;
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }
}


@end
