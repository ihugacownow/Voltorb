//
//  EventCreationView.h
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCreationView : UIView

// text field
@property (nonatomic, strong) UITextField *locationTextfield;
@property (nonatomic, strong) UITextField *descriptionTextfield;
@property (nonatomic, strong) UITextField *eventNameTextfield;
@property (nonatomic, strong) UITextField *dateTextfield;

// buttons
@property (nonatomic, strong) UIButton *createEventButton;
@property (nonatomic, strong) UIButton *editEventImageButton;

// image view
@property (nonatomic, strong) UIImageView *coverImageView;




@end
