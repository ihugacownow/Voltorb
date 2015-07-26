//
//  SignUpView.m
//  voltorp
//
//  Created by Lianhan Loh on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "SignUpView.h"
#import "Themes.h"


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
//        self.backgroundColor = [Themes lightBlueBackground];

        self.backgroundColor = [UIColor clearColor];
        

        
        self.nameField = [[CustomTextField alloc] initWithFrame: CGRectZero];
        self.nameField.placeholder = @"Name";
        self.nameField.font = [Themes textFieldFont];
//        self.nameField.layer.borderWidth = 1.0;
//        self.nameField.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.emailField = [[CustomTextField alloc] initWithFrame: CGRectZero];
        self.emailField.placeholder = @"Email";
//        self.emailField.layer.borderWidth = 1.0;
//        self.emailField.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.hpNumberField = [[CustomTextField alloc] initWithFrame: CGRectZero];
        self.hpNumberField.placeholder = @"HP Number";
//        self.hpNumberField.layer.borderWidth = 1.0;
//        self.hpNumberField.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.ICField = [[CustomTextField alloc] initWithFrame: CGRectZero];
        self.ICField.placeholder = @"NRIC";
//        self.ICField.layer.borderWidth = 1.0;
//        self.ICField.layer.borderColor = [UIColor blackColor].CGColor;
       
        self.passwordField = [[CustomTextField alloc] initWithFrame: CGRectZero];
        self.passwordField.placeholder = @"Password";
        self.passwordField.secureTextEntry = YES;
//        self.passwordField.layer.borderWidth = 1.0;
//        self.passwordField.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.signUpButton = [[UIButton alloc] init];
        [self.signUpButton setTitle: @"Register" forState: UIControlStateNormal];
        
        [self.signUpButton setTitleColor: [Themes darkBlue] forState: UIControlStateNormal];
        self.signUpButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        
        
        [self addSubview: self.nameField];
        [self addSubview: self.emailField];
        [self addSubview: self.hpNumberField];
        [self addSubview: self.ICField];
        [self addSubview: self.passwordField];
        [self addSubview: self.signUpButton];
        
        [self createImageView];
    }
    
    return self;
}



- (void) layoutSubviews
{
    float topBound = 210; // y coordinate of first field
    float leftMargin = 30;
    float width = self.bounds.size.width - leftMargin * 2;
    float height = 30;
    self.nameField.frame = CGRectMake(leftMargin, topBound, width, height);
    self.passwordField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.nameField.frame) + 20, width, height);
    self.ICField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.passwordField.frame) + 20, width, height);
    self.emailField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.ICField.frame) + 20, width, height);
    self.hpNumberField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.emailField.frame) + 20, width, height);

    // sign up button
    float buttonY = CGRectGetMaxY(self.hpNumberField.frame) + 30;
    self.signUpButton.frame = CGRectMake(0, buttonY, width, height);
    self.signUpButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.signUpButton setCenter: CGPointMake(self.bounds.size.width / 2, buttonY)];
    
    // edit image view
    double frameBuffer = 100;
    self.imageView.frame = CGRectMake(frameBuffer, 70, self.bounds.size.width - (frameBuffer * 2), self.bounds.size.width - (frameBuffer * 2));
}

- (void) createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIImageView *inset = [[UIImageView alloc] initWithFrame: CGRectMake(40, 40, 40, 40)];
    inset.image = [UIImage imageNamed:@"plus"];
    [self.imageView addSubview:inset];
    self.imageView.layer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    
    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
}



@end
