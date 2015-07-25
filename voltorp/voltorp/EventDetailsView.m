//
//  EventDetailsView.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "EventDetailsView.h"

@interface EventDetailsView ()

// image view
@property (nonatomic, strong) UIImageView *verifiedEventImageView;

// labels
@property (nonatomic, strong) UILabel *peopleGoingLabel;

@property (nonatomic, strong) UILabel *t1;
@property (nonatomic, strong) UILabel *t2;

@end

@implementation EventDetailsView
{
    BOOL isAdmin;
}

- (instancetype) initWithFrame:(CGRect) frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    
    return self;
}

- (void) layoutSubviews {
    // edit imageview
    self.coverImageView.frame = CGRectMake(0, 0, self.bounds.size.width, 150);
    
    // edit verified view
    self.verifiedEventImageView.frame = CGRectMake(self.bounds.size.width - 40, 160, 30, 30);
    
    // edit sign up button
    double buttonWidth = 100;
    self.signUpForEventButton.frame = CGRectMake((self.bounds.size.width - buttonWidth) / 2, 460, buttonWidth, 30);
    [self.signUpForEventButton setTitle:@"sign up" forState:UIControlStateNormal];
    [self.signUpForEventButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // edit 'edit' button
    if (isAdmin) {
        self.editEventButton.frame = CGRectMake(self.bounds.size.width - 70, 190, 60, 30);
        [self.editEventButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.editEventButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    // edit scroll view
    double scrollViewWidth = 280;
    self.peopleGoingScrollView.frame = CGRectMake((self.bounds.size.width - scrollViewWidth) / 2, 360, scrollViewWidth, 100);
}

- (void) loadUI {
    [self loadImageViews];
    [self loadLabels];
    [self loadButtons];
    [self loadScrollView];
}

- (void) loadImageViews {
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.coverImageView];

    self.verifiedEventImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.verifiedEventImageView.image = [UIImage imageNamed:@"verified.png"];
    [self addSubview:self.verifiedEventImageView];
}

- (void) loadLabels {
    self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 200, 30)];
    self.eventNameLabel.text = @"Event name";
    self.eventNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
//    self.eventNameLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.eventNameLabel.layer.borderWidth = 1.0;
    [self addSubview:self.eventNameLabel];
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 200, 30)];
    self.locationLabel.text = @"Location";
    self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
//    self.locationLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.locationLabel.layer.borderWidth = 1.0;
    [self addSubview:self.locationLabel];

    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 200, 30)];
    self.timeLabel.text = @"Time";
    self.timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
//    self.timeLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.timeLabel.layer.borderWidth = 1.0;
    [self addSubview:self.timeLabel];

    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 250, 80)];
    self.descriptionLabel.text = @"Description";
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
//    self.descriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.descriptionLabel.layer.borderWidth = 1.0;
    [self addSubview:self.descriptionLabel];
    
    self.peopleGoingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 330, 200, 30)];
    self.peopleGoingLabel.text = @"People going";
    self.peopleGoingLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
//    self.peopleGoingLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.peopleGoingLabel.layer.borderWidth = 1.0;
    [self addSubview:self.peopleGoingLabel];
    
}

- (void) loadButtons {
     // TODO: determine if user is event organizer
    isAdmin = YES;
    
    if (isAdmin) {
        self.editEventButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.editEventButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.editEventButton.layer.borderWidth = 1.0;
        [self addSubview:self.editEventButton];
    }

    self.signUpForEventButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.signUpForEventButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.signUpForEventButton.layer.borderWidth = 1.0;
    [self addSubview:self.signUpForEventButton];
}

- (void) loadScrollView {
    // scroll view for people going
    self.peopleGoingScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
//    self.peopleGoingScrollView.layer.borderWidth = 1.0;
//    self.peopleGoingScrollView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.peopleGoingScrollView];
}

@end
