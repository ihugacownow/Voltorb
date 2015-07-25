//
//  IssueViewController.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueViewController.h"
#import "IssueView.h"

@interface IssueViewController ()

@property (nonatomic, strong) IssueView *issueView;
@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.issueView = [[IssueView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.issueView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    // set view here
    self.issueView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

# pragma mark - selectors
- (void) addSelectors {
//    [self.takePhotoButton addTarget:self
//                         action:@selector(takePhoto:)
//               forControlEvents:UIControlEventTouchUpInside];
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
