//
//  LoginViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        
        
   
        self.emailField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.emailField.placeholder = @"Email";
        //        self.emailField.layer.borderWidth = 1.0;
        //        self.emailField.layer.borderColor = [UIColor blackColor].CGColor;
        
        
        self.passwordField = [[UITextField alloc] initWithFrame: CGRectZero];
        self.passwordField.placeholder = @"Password";
        self.passwordField.secureTextEntry = YES;
        
        [self addSubview: self.emailField];
        
        [self addSubview: self.passwordField];
        
        [self addSubview: self.loginButton];
        
        [self createImageView];
    }
    
    return self;
}



- (void) layoutSubviews
{
    float topBound = 180; // y coordinate of first field
    float leftMargin = 30;
    float width = self.bounds.size.width - leftMargin * 2;
    float height = 30;
    self.passwordField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.nameField.frame) + 20, width, height);
    self.emailField.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.ICField.frame) + 20, width, height);
    
    // sign up button
    float buttonY = CGRectGetMaxY(self.hpNumberField.frame) + 20;
    self.loginButton.frame = CGRectMake(0, buttonY, width, height);
    [self.loginButton setCenter: CGPointMake(self.bounds.size.width / 2, buttonY)];
    
    // edit image view
    double frameBuffer = 100;
    self.imageView.frame = CGRectMake(frameBuffer, 40, self.bounds.size.width - (frameBuffer * 2), self.bounds.size.width - (frameBuffer * 2));
}

- (void) createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.layer.borderWidth = 1.0;
    
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
}



@end
