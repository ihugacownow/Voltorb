//
//  IssueView.h
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueView : UIView 

// buttons
@property (nonatomic, strong) UIButton *submitButton;

// UIImageView for photo
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

// text fields
@property (nonatomic, strong) UITextField *detailsTextField;
@property (nonatomic, strong) UITextField *incidentLocationTextField;
@property (nonatomic, strong) NSString *postal; 


@end
