//
//  EventCreationViewController.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "EventCreationViewController.h"
#import "EventCreationView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Parse/Parse.h>

@interface EventCreationViewController ()

@property (nonatomic, strong) EventCreationView *eventCreationView;

@end

@implementation EventCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.eventCreationView = [[EventCreationView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.eventCreationView];
    
    [self.eventCreationView.locationTextfield setDelegate:self];
    [self.eventCreationView.descriptionTextfield setDelegate:self];
    [self.eventCreationView.eventNameTextfield setDelegate:self];
    [self.eventCreationView.dateTextfield setDelegate:self];

    [self addSelectors];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    self.eventCreationView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

# pragma mark - add selectors
- (void) addSelectors {
    // selector for submit button
    [self.eventCreationView.editEventImageButton addTarget:self
                                    action:@selector(editImageButtonPressed:)
                          forControlEvents:UIControlEventTouchUpInside];

    [self.eventCreationView.createEventButton addTarget:self
                                                    action:@selector(createEventButtonPressed:)
                                          forControlEvents:UIControlEventTouchUpInside];

}

# pragma mark - selectors
- (IBAction) editImageButtonPressed:(id)sender
{
    NSLog(@"edit image button pressed");
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

- (IBAction )createEventButtonPressed:(id)sender {
    NSLog(@"creating event now!");
    [self createEvent];
}

# pragma mark - database queries
- (void) createEvent {
    PFObject *object = [PFObject objectWithClassName:@"Event"];
    object[@"location"] = self.eventCreationView.locationTextfield.text;
    object[@"description"] = self.eventCreationView.descriptionTextfield.text;
    object[@"eventName"] = self.eventCreationView.eventNameTextfield.text;
    object[@"peopleGoing"] = @[];
    
    NSString *timeString = self.eventCreationView.dateTextfield.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:timeString];
    object[@"time"] = dateFromString;
    
    // store image
    NSData* data = UIImageJPEGRepresentation(self.eventCreationView.coverImageView.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"overwrite.jpg" data:data];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [object setObject:imageFile forKey:@"eventPhoto"];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"new event created");
                } else {
                    NSLog(@"error in creating new issue");
                }
            }];
        }
    }];
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
    self.eventCreationView.coverImageView.image = chosenImage;
    
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
