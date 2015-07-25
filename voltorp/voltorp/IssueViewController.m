//
//  IssueViewController.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueViewController.h"
#import "IssueView.h"
#import <Parse/Parse.h>

@interface IssueViewController ()

@property (nonatomic, strong) IssueView *issueView;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.issueView = [[IssueView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.issueView];
    
    // further set up of IssueView
    [self addGestureRecognizers];    
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
// TODO: waichoong - add picker here
- (void) tapImageView: (id)sender {
    //handle Tap...
    NSLog(@"tapped image view to upload image");
}

- (IBAction) submitButtonPressed:(id)sender
{
    NSLog(@"submit button pressed");
    // 1. TODO: check if all fields are complete
    
    
    // 2. update to database
    [self uploadIssueToParse];
}

# pragma mark - database queries
- (void) uploadIssueToParse {
    // TODO: upload to parse
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
