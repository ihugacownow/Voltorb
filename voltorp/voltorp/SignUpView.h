//
//  SignUpView.h
//  voltorp
//
//  Created by Lianhan Loh on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface SignUpView : UIView

@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) CustomTextField *nameField;
@property (strong, nonatomic) CustomTextField *emailField;
@property (strong, nonatomic) CustomTextField *hpNumberField;
@property (strong, nonatomic) CustomTextField *ICField;
@property (strong, nonatomic) CustomTextField *passwordField;

// UIImageView for photo
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end
