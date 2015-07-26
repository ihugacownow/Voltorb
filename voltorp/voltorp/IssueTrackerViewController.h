//
//  IssueTrackerViewController.h
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface IssueTrackerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PFObject *issue;

- (void)updateState;

@end
