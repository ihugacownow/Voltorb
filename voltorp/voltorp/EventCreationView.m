//
//  EventCreationView.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "EventCreationView.h"

@interface EventCreationView ()

// image view
@property (nonatomic, strong) UIImageView *editEventImageView;

@end

@implementation EventCreationView

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
    self.editEventImageView.frame = CGRectMake(self.bounds.size.width - 75, 125, 25, 25);
    
    // edit sign up button
    double buttonWidth = 200;
    self.createEventButton.frame = CGRectMake((self.bounds.size.width - buttonWidth) / 2, 460, buttonWidth, 30);
    [self.createEventButton setTitle:@"Create" forState:UIControlStateNormal];
    [self.createEventButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.createEventButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.createEventButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    // edit "edit event image" button
    self.editEventImageButton.frame = CGRectMake(self.bounds.size.width - 30, 110, 20, 20);
    [self.editEventImageButton setBackgroundImage:[UIImage imageNamed:@"editImage.png"] forState:UIControlStateNormal];
    [self.editEventImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (void) loadUI {
    
    [self loadImageViews];
    [self loadLabelsAndTextFields];
    [self loadButtons];
}

- (void) loadImageViews {
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.coverImageView];
    self.coverImageView.alpha = 0.7;
}

- (void) loadLabelsAndTextFields {
    self.eventNameTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, 200, 30)];
    self.eventNameTextfield.placeholder = @"Event name";
    self.eventNameTextfield.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    //    self.eventNameLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //    self.eventNameLabel.layer.borderWidth = 1.0;
    [self addSubview:self.eventNameTextfield];
    
    self.locationTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, 200, 30)];
    self.locationTextfield.placeholder = @"Location";
    self.locationTextfield.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    //    self.locationLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //    self.locationLabel.layer.borderWidth = 1.0;
    [self addSubview:self.locationTextfield];

    //  date picker
    self.dateTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 200, 30)];
    self.dateTextfield.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
//    self.dateTextfield.layer.borderColor = [UIColor blackColor].CGColor;
//    self.dateTextfield.layer.borderWidth = 1.0;
    self.dateTextfield.placeholder = @"DD/MM/YY";
    [self addSubview:self.dateTextfield];
    
    self.descriptionTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 240, 250, 80)];
    self.descriptionTextfield.placeholder = @"Description";
    self.descriptionTextfield.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    //    self.descriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //    self.descriptionLabel.layer.borderWidth = 1.0;
    [self addSubview:self.descriptionTextfield];
    
}

- (void) loadButtons {  
    self.createEventButton = [[UIButton alloc] initWithFrame:CGRectZero];
//    self.createEventButton.layer.borderColor = [UIColor blackColor].CGColor;
//    self.createEventButton.layer.borderWidth = 1.0;
    [self addSubview:self.createEventButton];
    
    self.editEventImageButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.editEventImageButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.editEventImageButton.layer.borderWidth = 1.0;
    [self addSubview:self.editEventImageButton];
}

@end
