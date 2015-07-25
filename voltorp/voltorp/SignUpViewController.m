//
//  SignUpViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpView.h"
#import <Parse/parse.h>

@interface SignUpViewController () <UIImagePickerControllerDelegate>

@property (strong, nonatomic) SignUpView *signUpView;
@property (strong, nonatomic) UIImageView *photoView;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.signUpView = [[SignUpView alloc] initWithFrame: CGRectZero];
    [self.view addSubview: self.signUpView];
    [self.signUpView.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpView.signUpButton addTarget:self action:@selector(signUp) forControlEvents: UIControlEventTouchUpInside];
}

- (void) viewDidLayoutSubviews {
    self.signUpView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) takePhoto {
    // Put in code
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    cameraUI.delegate = self;
    
    [self presentModalViewController: cameraUI animated: YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    
}

#pragma mark - Sign up
- (void) signUp {
    PFUser *user = [PFUser user];
    NSLog(@"button pressed");
    NSLog(@"%@", self.signUpView.nameField.text);
    user[@"firstName"] = self.signUpView.nameField.text;
    user[@"lastName"] = @""; // get around the lastName field in Parse
    user[@"email"] = self.signUpView.emailField.text;
    user[@"handphone Number"] = self.signUpView.hpNumberField.text;
    user[@"username"] = self.signUpView.ICField.text;
    NSLog(@"password entry is %@", self.signUpView.passwordField.text);
    user.password = self.signUpView.passwordField.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"user saved to Parse");
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
     }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
