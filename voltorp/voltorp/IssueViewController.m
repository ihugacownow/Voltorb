//
//  IssueViewController.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueViewController.h"
#import "IssueView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Parse/Parse.h>

@interface IssueViewController ()

@property (nonatomic, strong) IssueView *issueView;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.issueView = [[IssueView alloc] initWithFrame:CGRectZero];
    self.issueView.detailsTextField.delegate = self;
    self.issueView.incidentLocationTextField.delegate = self; 
    
    [self.view addSubview:self.issueView];
    
    // further set up of IssueView
    [self addGestureRecognizers];
    [self addSelectors];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    // set view here
    self.issueView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

# pragma mark - gesture recognizers
- (void) addGestureRecognizers {

    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapImageView:)];
    tapGesture1.numberOfTapsRequired = 1;
    [tapGesture1 setDelegate:self];
    [self.issueView.imageView addGestureRecognizer:tapGesture1];
}

- (void) addSelectors {
    // selector for submit button
    [self.issueView.submitButton addTarget:self
               action:@selector(submitButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
}

# pragma mark - selectors
- (IBAction) submitButtonPressed:(id)sender
{
    NSLog(@"submit button pressed");
    // update to database
    [self uploadIssueToParse];
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
    self.issueView.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - database queries
- (void) uploadIssueToParse {
    NSLog(@"uploading issue to parse");
    PFObject *issueStore = [PFObject objectWithClassName:@"Issue"];
    
    NSString *details = self.issueView.detailsTextField.text;
    issueStore[@"description"] = details;

    // TODO: update location
    NSString *location = self.issueView.incidentLocationTextField.text;
    issueStore[@"locationTuple"] = [PFGeoPoint geoPointWithLatitude:40.0 longitude:-30.0];
    issueStore[@"issueStatus"] = @"WIP";
//    issueStore[@"createdBy"] = [PFUser currentUser].objectId; // TODO: need to change back
    issueStore[@"createdBy"] = @"rghzVlOB8Z"; // TODO: need to change back
    
    NSLog(@"issue store is %@", issueStore);
    
    // store image
    NSData* data = UIImageJPEGRepresentation(self.issueView.imageView.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"overwrite.jpg" data:data];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [issueStore setObject:imageFile forKey:@"issuePhoto"];
            [issueStore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"new issue created");
                } else {
                    NSLog(@"error in creating new issue");
                }
            }];
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
