//
//  EventDetailsViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "EventDetailsView.h"

@interface EventDetailsViewController ()

@property (nonatomic, strong) EventDetailsView *eventDetailsView;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eventDetailsView = [[EventDetailsView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.eventDetailsView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    self.eventDetailsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
