//
//  IssueTracker.h
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueTrackerView : UIView

// table view
@property (nonatomic, strong) UITableView *postsTableView;

// labels
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *eventDetails;

// issue photo
@property (nonatomic, strong) UIImageView *issueImageView;

// buttons
@property (nonatomic, strong) UIButton *proposeNewEventButton;

@end
