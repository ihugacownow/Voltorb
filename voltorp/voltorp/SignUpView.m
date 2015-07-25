//
//  SignUpView.m
//  voltorp
//
//  Created by Lianhan Loh on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "SignUpView.h"

@interface SignUpView()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UILabel *hpNumberLabel;



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
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        self.nameLabel.text = @"Name:";
        self.nameField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.nameField.placeholder = @"Fill in name";
        
        self.emailLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        self.emailLabel.text = @"Email:";
        self.emailField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.emailField.placeholder = @"Fill in Email";
        
        self.hpNumberLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        self.hpNumberLabel.text = @"Handphone Number:";
        self.hpNumberField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.hpNumberField.placeholder = @"Fill in HP Number";
        
        self.signUpButton = [[UIButton alloc] init];
        [self.signUpButton setTitle: @"Register" forState: UIControlStateNormal];
        [self.signUpButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
//        self.signUpButton.titleLabel.text = @"Register";
//        self.signUpButton.titleLabel.textColor = [UIColor blackColor];
        
        [self addSubview: self.nameLabel];
        [self addSubview: self.emailLabel];
        [self addSubview: self.nameField];
        [self addSubview: self.emailField];
        [self addSubview: self.hpNumberLabel];
        [self addSubview: self.hpNumberField];
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
    self.nameLabel.frame = CGRectMake(leftMargin, 100, width, height);
    self.nameField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.nameLabel.frame) + 20, 400, height);
    self.emailLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.nameField.frame) + 20, width, height);
    self.emailField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.emailLabel.frame) + 20, 400, height);
    self.hpNumberLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.emailField.frame) + 20, width, height);
    self.hpNumberField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.hpNumberLabel.frame) + 20, width, height);
    
    float buttonY = CGRectGetMaxY(self.hpNumberField.frame) + 20;
    self.signUpButton.frame = CGRectMake(0, buttonY, width, height);
    [self.signUpButton setCenter: CGPointMake(self.bounds.size.width / 2, buttonY)];
}



@end
