//
//  IssueTrackerViewController.m
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueTrackerViewController.h"
#import "IssueTrackerView.h"

@interface IssueTrackerViewController ()

@property (strong, nonatomic) IssueTrackerView *issueTrackerView;

@end

@implementation IssueTrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.issueTrackerView = [[IssueTrackerView alloc] initWithFrame: CGRectZero];
    [self.view addSubview: self.issueTrackerView];
    // Do any additional setup after loading the view.
}

- (void) viewDidLayoutSubviews {
    self.issueTrackerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
