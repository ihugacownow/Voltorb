//
//  SignUpView.m
//  voltorp
//
//  Created by Lianhan Loh on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "SignUpView.h"

@interface SignUpView()

@end

@implementation SignUpView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.nameField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.nameField.placeholder = @"Name";
        
        self.emailField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.emailField.placeholder = @"Email";
        
        self.hpNumberField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.hpNumberField.placeholder = @"HP Number";
        
        self.ICField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.ICField.placeholder = @"NRIC";
       
        self.passwordField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.passwordField.placeholder = @"Password";
        self.passwordField.secureTextEntry = YES;
        
        self.signUpButton = [[UIButton alloc] init];
        [self.signUpButton setTitle: @"Register" forState: UIControlStateNormal];
        [self.signUpButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        
        [self addSubview: self.nameField];
        [self addSubview: self.emailField];
        [self addSubview: self.hpNumberField];
        [self addSubview: self.ICField];
        [self addSubview: self.passwordField];
        [self addSubview: self.signUpButton];
        
        // Let jevon implement the UIImagePicker
        self.takePhotoButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:self.takePhotoButton];
    }
    
    return self;
}



- (void) layoutSubviews
{
    float leftMargin = 30;
    float width = self.bounds.size.width - leftMargin * 2;
    float height = 20;
    self.nameField.frame = CGRectMake(leftMargin, 100, 400, height);
    self.passwordField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.nameField.frame) + 20, width, height);
    self.ICField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.passwordField.frame) + 20, 400, height);
    self.emailField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.ICField.frame) + 20, 400, height);
    self.hpNumberField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.emailField.frame) + 20, width, height);

    
    float buttonY = CGRectGetMaxY(self.hpNumberField.frame) + 20;
    self.signUpButton.frame = CGRectMake(0, buttonY, width, height);
    [self.signUpButton setCenter: CGPointMake(self.bounds.size.width / 2, buttonY)];
}



@end
