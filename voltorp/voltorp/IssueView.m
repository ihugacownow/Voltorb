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
    // edit top bar width
    self.topBarName.frame = CGRectMake(0, 0, self.bounds.size.width, 50);
    
    // edit category label width
    self.categoryLabel.frame = CGRectMake(0, 60, self.bounds.size.width, 20);
    
    // edit image view
    double frameBuffer = 80;
    self.imageView.frame = CGRectMake(frameBuffer, 90, self.bounds.size.width - (frameBuffer * 2), self.bounds.size.width - (frameBuffer * 2));
    
    // edit submit button
    double widthOfSubmitButton = 100;
    self.submitButton.frame = CGRectMake((self.bounds.size.width - widthOfSubmitButton)/2, 480, widthOfSubmitButton, 30);
    [self.submitButton setTitle:@"submit" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // edit description textfield
    self.detailsTextField.frame = CGRectMake(30, 355, self.bounds.size.width - 60, 110);
    self.detailsTextField.placeholder = @"(e.g. monkeys are a public nuisance)";
    
    // edit location textfield
    self.incidentLocationTextField.frame = CGRectMake(30, 300, self.bounds.size.width - 60, 30);
    self.incidentLocationTextField.placeholder = @"waichoong, fix this";
}

- (void) loadUI {
    [self loadTopBar];
    [self createTextLabels];
    [self createTextFields];
    [self createButtons];
    [self createImageView];
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
    self.categoryLabel.text = @"<category>";
    self.categoryLabel.textAlignment = NSTextAlignmentCenter;
    self.categoryLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    [self addSubview:self.categoryLabel];
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 270, 200, 30)];
    self.locationLabel.text = @"Incident was seen at:";
    self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    [self addSubview:self.locationLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 325, 200, 30)];
    self.descriptionLabel.text = @"Details";
    self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    [self addSubview:self.descriptionLabel];
}

- (void) createTextFields {
    self.incidentLocationTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.incidentLocationTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.incidentLocationTextField.layer.borderWidth = 1.0;
    [self addSubview:self.incidentLocationTextField];
    
    self.detailsTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.detailsTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.detailsTextField.layer.borderWidth = 1.0;
    [self addSubview:self.detailsTextField];
}

- (void) createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
}

- (void) createButtons {
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.submitButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.submitButton.layer.borderWidth = 1.0;
    [self addSubview:self.submitButton];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
