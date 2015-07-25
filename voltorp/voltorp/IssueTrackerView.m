//
//  IssueTracker.m
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueTrackerView.h"
#import "PostView.h"
#import <Parse/parse.h>

@interface IssueTrackerView()

//event photo
@property (nonatomic, strong) UIImageView *issueImageView;

// labels
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *discussionLabel;
@property (nonatomic, strong) UILabel *issueNameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;


// buttons
@property (nonatomic, strong) UIButton *eventButton;
@property (nonatomic, strong) UIButton *resolutionButton;

// scroll view
@property (nonatomic, strong) UIScrollView *postsScrollView;



@end

@implementation IssueTrackerView


- (instancetype) initWithFrame:(CGRect) frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    
    return self;
}

- (void) layoutSubviews {
    
    self.issueImageView.frame = CGRectMake(170, 20, 120, 120);
    
    
}

#pragma mark - load UI
- (void) loadUI {
    [self loadBanner];
    [self loadDiscussionHeader];
    [self loadPosts];
    
}

- (void) loadBanner {
    self.issueImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.issueImageView.image = [UIImage imageNamed:@"testImage.jpg"];
    self.issueImageView.layer.borderWidth = 1;
    self.issueImageView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.issueImageView];
    
    self.issueNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 20, 100, 30)];
    self.issueNameLabel.text = @"Issue name"; // get issue name from data base
    [self addSubview:self.issueNameLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 50, 120, 90)];
    NSString *description = @"This is a really really really really really really long description about an issue. Please discuss and discuss and see if you can help out. If you can't just talk a lot about it and hope more people get interested about it. Maybe they can help out.";
   // NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString: description];
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    [style setLineSpacing: 40];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.text = description;
    self.descriptionLabel.layer.borderWidth = 1;
    self.descriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.descriptionLabel];
}

- (void) loadDiscussionHeader {
    self.progressLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 150, 160, 20)];
    self.progressLabel.text = @"Discussion on-going";
    self.progressLabel.backgroundColor = [UIColor orangeColor];
    self.progressLabel.layer.borderWidth = 1.0;
    self.progressLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.progressLabel];

    self.resolutionButton = [[UIButton alloc] initWithFrame: CGRectMake(210, 150, 80, 20)];
    [self.resolutionButton setTitle: @"Resolved" forState: UIControlStateNormal];
    [self.resolutionButton setBackgroundColor: [UIColor redColor]];
    [self addSubview:self.resolutionButton];
}

- (void) loadPosts {
    
    NSArray *posts = @[[NSDictionary dictionaryWithObjectsAndKeys:
                        [UIImage imageNamed:@"verified.png"], @"userPic",
                        @"Wai Wu", @"username",
                        @"This is a description", @"description",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        [UIImage imageNamed:@"testImage.png"], @"userPic",
                        @"Jevon Yeoh", @"username",
                        @"description is this", @"description",
                        nil]];
    
    float yOffSet = 0;
    // list posts
    for (int i = 0; i < [posts count]; i++) {
        
    }
    
}

#pragma mark - database query 

- (void) databaseQuery {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
