//
//  IssueView.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueView.h"

@interface IssueView ()

// top bar
@property (nonatomic, strong) UILabel *topBarName;

// text labels
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *categoryLabel; // if necessary

// UIImageView for photo
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation IssueView

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
    self.categoryLabel.frame = CGRectMake(0, 60, self.bounds.size.width, 20);
}

- (void) loadUI {
    [self loadTopBar];
    [self createTextLabels];
    [self createTextFields];
    [self createButtons];
}

- (void) loadTopBar {
    self.topBarName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.topBarName.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    self.topBarName.text = @"Create Issue";
    self.topBarName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.topBarName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.topBarName];
}

- (void) createTextLabels {
    self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.categoryLabel.text = @"Category";
    self.categoryLabel.textAlignment = NSTextAlignmentCenter;
    self.categoryLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    self.categoryLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.categoryLabel.layer.borderWidth = 1.0;
    [self addSubview:self.categoryLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 95, 200, 30)];
    self.descriptionLabel.text = @"Details";
    self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    self.descriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.descriptionLabel.layer.borderWidth = 1.0;
    [self addSubview:self.descriptionLabel];
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 115, 200, 30)];
    self.locationLabel.text = @"Incident was seen at:";
    self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    self.locationLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.locationLabel.layer.borderWidth = 1.0;
    [self addSubview:self.locationLabel];
    
}

- (void) createTextFields {
    
}

- (void) createButtons {
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 30, 50)];
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    self.submitButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.submitButton.layer.borderWidth = 1.0;
    [self addSubview:self.submitButton];
    
    self.takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 30, 50)];
    [self.takePhotoButton setTitle:@"Take photo" forState:UIControlStateNormal];
    self.takePhotoButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.takePhotoButton.layer.borderWidth = 1.0;
    [self addSubview:self.takePhotoButton];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
