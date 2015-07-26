//
//  ProfileView.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "ProfileView.h"

@interface ProfileView ()

// top bar
@property (nonatomic, strong) UILabel *topBarName;

@end

@implementation ProfileView

// override
- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self loadUI];
    }
    
    return self;
}

- (void) layoutSubviews {
    self.topBarName.frame = CGRectMake(0, 0, self.bounds.size.width, 50);
    self.issuesTableView.frame = CGRectMake(30, 225, self.bounds.size.width - 60, 250);
}

- (void) loadUI {
    [self loadTopBar];
    [self createTextLabels];
    [self loadProfilePictureImageView];
    [self loadTableView];

}

- (void) loadTopBar {
    self.topBarName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.topBarName.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.8];
    self.topBarName.text = @"Profile";
    self.topBarName.textColor = [UIColor whiteColor];
    self.topBarName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.topBarName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.topBarName];
}

- (void) createTextLabels {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 95, 200, 30)];
    self.nameLabel.text = @"Wai Choong";
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
//    self.nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.nameLabel.layer.borderWidth = 1.0;
    [self addSubview:self.nameLabel];

    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 115, 200, 30)];
    self.locationLabel.text = @"Serangoon";
    self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
//    self.locationLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.locationLabel.layer.borderWidth = 1.0;
    [self addSubview:self.locationLabel];
    
    self.hoursVolunteeredLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 165, 80, 20)];
    self.hoursVolunteeredLabel.text = @"6 hours";
    self.hoursVolunteeredLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
    self.hoursVolunteeredLabel.textAlignment = NSTextAlignmentCenter;
//    self.hoursVolunteeredLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.hoursVolunteeredLabel.layer.borderWidth = 1.0;
//    [self addSubview:self.hoursVolunteeredLabel];
    
    self.eventsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 190, 200, 30)];
    self.eventsLabel.text = @"Issues Posted";
    self.eventsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
//    self.eventsLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.eventsLabel.layer.borderWidth = 1.0;
    [self addSubview:self.eventsLabel];

}

- (void) loadProfilePictureImageView {
    self.profilePictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80, 80, 80)];
    self.profilePictureImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.profilePictureImageView.layer.borderWidth = 1.0;
    self.profilePictureImageView.image = [UIImage imageNamed:@"verified.png"];
    
    self.profilePictureImageView.layer.cornerRadius = 60.00;
    self.profilePictureImageView.layer.masksToBounds = YES;
    
    [self addSubview:self.profilePictureImageView];
}

- (void) loadTableView {
    self.issuesTableView = [[UITableView alloc] initWithFrame:CGRectZero];
//    self.issuesTableView.layer.borderWidth = 1.0;
//    self.issuesTableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.issuesTableView.layer.cornerRadius = 7;
    self.issuesTableView.layer.masksToBounds = YES;
    [self addSubview:self.issuesTableView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
