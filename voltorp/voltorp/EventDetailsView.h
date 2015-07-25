//
//  EventDetailsView.h
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailsView : UIView

// labels
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *eventNameLabel;

// scroll view
@property (nonatomic, strong) UIScrollView *peopleGoingScrollView;

// buttons
@property (nonatomic, strong) UIButton *editEventButton;
@property (nonatomic, strong) UIButton *signUpForEventButton;


@end
