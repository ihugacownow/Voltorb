//
//  IssueTracker.m
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueTrackerView.h"
#import <Parse/parse.h>

@interface IssueTrackerView()

// labels
@property (nonatomic, strong) UILabel *discussionLabel;
@property (nonatomic, strong) UILabel *scheduledEventLabel;

// buttons

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
    
    double scrollViewWidth = 265;
    self.postsTableView.frame = CGRectMake((self.bounds.size.width - scrollViewWidth) / 2, 200, scrollViewWidth, 240);
//    self.postsTableView.layer.borderColor = [UIColor blackColor].CGColor;
//    self.postsTableView.layer.borderWidth = 1.0;
    
    double buttonWidth = 200;
    self.proposeNewEventButton.frame = CGRectMake((self.bounds.size.width - buttonWidth) / 2, 450, buttonWidth, 30);
    [self.proposeNewEventButton setTitle:@"propose solution" forState:UIControlStateNormal];
    [self.proposeNewEventButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.resolutionButton.frame = CGRectMake((self.bounds.size.width - buttonWidth) / 2, 500, buttonWidth, 30);
    [self.resolutionButton setTitle:@"Home page" forState:UIControlStateNormal];
    [self.resolutionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

#pragma mark - load UI
- (void) loadUI {
    [self loadBanner];
    [self loadDiscussionHeader];
    [self loadButton];
    [self createEventLabels];
}

- (void) loadBanner {
    self.issueImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.issueImageView.image = [UIImage imageNamed:@"testImage.jpg"];
//    self.issueImageView.layer.borderWidth = 1;
//    self.issueImageView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.issueImageView];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 20, 120, 120)];
    NSString *description = @"Description.";
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    self.descriptionLabel.text = description;
//    self.descriptionLabel.layer.borderWidth = 1;
//    self.descriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.descriptionLabel];
}

- (void) loadDiscussionHeader {
    self.resolutionButton = [[UIButton alloc] initWithFrame: CGRectMake(190, 150, 100, 20)];
    [self.resolutionButton setTitle: @"Unresolved" forState: UIControlStateNormal];
    [self.resolutionButton setBackgroundColor: [UIColor redColor]];
    [self addSubview:self.resolutionButton];

    self.postsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.postsTableView];
}

- (void) createEventLabels {
    self.scheduledEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 155, 200, 20)];
    self.scheduledEventLabel.text = @"Next steps";
    self.scheduledEventLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
//    self.scheduledEventLabel.layer.borderWidth = 1.0;
//    self.scheduledEventLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.scheduledEventLabel];
    
    self.eventDetails = [[UILabel alloc] initWithFrame:CGRectMake(30, 165, 200, 30)];
    self.eventDetails.text = @"Scheduled event details here!";
    self.eventDetails.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
//    self.eventDetails.layer.borderWidth = 1.0;
//    self.eventDetails.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.eventDetails];
}

- (void) loadButton {
    self.proposeNewEventButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.resolutionButton = [[UIButton alloc] initWithFrame:CGRectZero];
//    self.proposeNewEventButton.layer.borderColor = [UIColor blackColor].CGColor;
//    self.proposeNewEventButton.layer.borderWidth = 1.0;
    [self addSubview:self.proposeNewEventButton];
    [self addSubview:self.resolutionButton];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
