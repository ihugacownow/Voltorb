//
//  IssuesTabBarController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssuesTabBarController.h"
#import "ArchiveViewController.h" 
#import "CurrentIssuesViewController.h" 

@interface IssuesTabBarController ()

@property (strong, nonatomic) UIViewController *oldIssues;
@property (strong, nonatomic) UIViewController *currentIssues;

@end

@implementation IssuesTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.oldIssues = [[ArchiveViewController alloc] init];
    self.currentIssues = [[CurrentIssuesViewController alloc] init];
    
    NSArray *controllers = [NSArray arrayWithObjects:self.oldIssues, self.currentIssues, nil];
    self.viewControllers = controllers; 
    
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
