//
//  PostDiscTBController.m
//  voltorp
//
//  Created by Ignatius Admin on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "PostDiscTBController.h"


@interface PostDiscTBController ()


@end

@implementation PostDiscTBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileVC = [[ProfileViewController alloc] init];
    self.listVC = [[ArchivedIssuesViewController alloc] init];
    self.discoverVC = [[DiscoverViewController alloc] init];
 
    
    self.viewControllers = [[NSMutableArray alloc] initWithObjects:self.profileVC, self.discoverVC, self.listVC, nil];
    
    
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