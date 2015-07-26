//
//  SignUpViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpView.h"
#import "DiscoverViewController.h"
#import <Parse/parse.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Themes.h"

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
    [self.signUpView.signUpButton addTarget:self action:@selector(goToDiscoverVC) forControlEvents: UIControlEventTouchUpInside];
        [self addGestureRecognizers];
    
    self.signUpView.nameField.delegate = self;
    self.signUpView.emailField.delegate = self;
    self.signUpView.hpNumberField.delegate = self;

    self.signUpView.ICField.delegate = self;
    self.signUpView.passwordField.delegate = self;


    
}

- (void) viewDidLayoutSubviews {
    self.signUpView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - gesture recognizers
- (void) addGestureRecognizers {
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapImageView:)];
    tapGesture1.numberOfTapsRequired = 1;
    [tapGesture1 setDelegate:self];
    [self.signUpView.imageView addGestureRecognizer:tapGesture1];
}

#pragma mark - Sign up
- (void) signUp {
    PFUser *user = [PFUser user];
    NSLog(@"button pressed");
    NSLog(@"%@", self.signUpView.nameField.text);
    user[@"firstName"] = self.signUpView.nameField.text;
    user[@"lastName"] = @""; // get around the lastName field in Parse
    user[@"email"] = self.signUpView.emailField.text;
    user[@"handphoneNumber"] = self.signUpView.hpNumberField.text;
    user[@"username"] = self.signUpView.ICField.text;
    NSLog(@"password entry is %@", self.signUpView.passwordField.text);
    user.password = self.signUpView.passwordField.text;
    
    // store image
    NSData* data = UIImageJPEGRepresentation(self.signUpView.imageView.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"overwrite.jpg" data:data];

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [user setObject:imageFile forKey:@"profilePicture"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"user saved to Parse");
                } else {
                    NSLog(@"%@", [error localizedDescription]);
                }
            }];
        }
     }];
    
}

- (void) goToDiscoverVC {
    DiscoverViewController *vc = [[DiscoverViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction) tapImageView:(id)sender {
    NSLog(@"tapped image view to upload image");
    // check if photo settings are allowed
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No access to photos"
                                                            message:@"Please allow access to your photos or Camera in Settings to use this feature."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    } else {
        UIActionSheet *choosePhoto = [[UIActionSheet alloc] initWithTitle:@"How do you want to select a picture?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take Picture", @"Choose Picture", nil];
        choosePhoto.tag = 20;
        [choosePhoto showInView:self.view];
    }
}

#pragma mark - ActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // handle multiple actionsheets
    if (actionSheet.tag == 20) {
        if (buttonIndex == 0) {
            [self takePicture];
        } else if (buttonIndex == 1) {
            [self choosePicture];
        }
    }
}

#pragma mark - handle photo
- (void)takePicture
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *noCamera = [[UIAlertView alloc] initWithTitle:@"Error"
                                                           message:@"This device does not seem to have a camera."
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil, nil];
        [noCamera show];
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker
                           animated:YES
                         completion:nil];
    }
}

- (void)choosePicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker
                       animated:YES
                     completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.signUpView.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
