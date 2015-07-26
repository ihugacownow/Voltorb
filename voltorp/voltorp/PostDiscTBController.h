//
//  PostDiscTBController.h
//  voltorp
//
//  Created by Ignatius Admin on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "ArchivedIssuesViewController.h"
#import "DiscoverViewController.h"

@interface PostDiscTBController : UITabBarController

@property(strong,nonatomic) ProfileViewController *profileVC;
@property(strong,nonatomic) DiscoverViewController *discoverVC;
@property(strong,nonatomic) ArchivedIssuesViewController *listVC;

@end
