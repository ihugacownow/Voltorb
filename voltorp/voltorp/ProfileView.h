//
//  ProfileView.h
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileView : UIView

// text labels
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel* locationLabel;
@property (nonatomic, strong) UILabel* organizationPartOfLabel;
@property (nonatomic, strong) UILabel* interestsLabel;
@property (nonatomic, strong) UILabel* eventsLabel;
@property (nonatomic, strong) UILabel* hoursVolunteeredLabel;

// table views
@property (nonatomic, strong) UITableView *issuesTableView;

// image view
@property (nonatomic, strong) UIImageView *profilePictureImageView;

@end
