//
//  EventDetailsViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "EventDetailsView.h"
#import <Parse/Parse.h>

@interface EventDetailsViewController ()

@property (nonatomic, strong) EventDetailsView *eventDetailsView;

@end

@implementation EventDetailsViewController
{
    PFObject *currentEventDetailsPFO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eventDetailsView = [[EventDetailsView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.eventDetailsView];
    
    NSMutableDictionary *test = [self retrieveEventWithObjectID:@"HrYz7LiPAo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    self.eventDetailsView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

# pragma mark - database query
- (NSMutableDictionary *) retrieveEventWithObjectID: (NSString *) objectID {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"objectId" equalTo:objectID];
    
    NSArray *results = [query findObjects];
    if ([results count]) {
        currentEventDetailsPFO = [results objectAtIndex:0];
        
        self.eventDetailsView.eventNameLabel.text = currentEventDetailsPFO[@"eventName"];
        self.eventDetailsView.descriptionLabel.text = currentEventDetailsPFO[@"description"];
        NSString *dateString = [NSDateFormatter localizedStringFromDate:currentEventDetailsPFO[@"time"]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];
        self.eventDetailsView.timeLabel.text = dateString;
        self.eventDetailsView.locationLabel.text = currentEventDetailsPFO[@"location"];

        NSLog(@"people going are %@", currentEventDetailsPFO[@"peopleGoing"]);
        [self populateScrollView:currentEventDetailsPFO[@"peopleGoing"]];
    } else {
        NSLog(@"error retrieving events from query");
    }

    return [[NSMutableDictionary alloc] init];
}

- (void) signUpDatabaseCall {
    NSArray *peopleGoing = currentEventDetailsPFO[@"peopleGoing"];
    NSString *currentUserID = [PFUser currentUser].objectId;
    
    if (![peopleGoing containsObject:currentUserID]) {
        NSMutableArray *newPeopleGoing = [[NSMutableArray alloc] initWithArray:peopleGoing];
        [newPeopleGoing addObject:currentUserID];
        currentEventDetailsPFO[@"peopleGoing"] = newPeopleGoing;
        [currentEventDetailsPFO saveInBackground];
    }
}

# pragma mark - scroll view

- (void) populateScrollView:(NSArray *) peopleGoing {
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" containedIn:peopleGoing];
    
    // initialize scroll view
    self.eventDetailsView.peopleGoingScrollView.pagingEnabled = NO;
    self.eventDetailsView.peopleGoingScrollView.showsHorizontalScrollIndicator = NO;
    
    NSArray *results = [query findObjects];
    if ([results count]) {
        
        double profilePictureViewWidth = 50;
        double finalWidth = 0;
        double buffer = 5;
        
        for (int i = 0; i < [results count]; i++) {
            PFObject *currObj = [results objectAtIndex:i];
            
            int xCoord = i * (profilePictureViewWidth + buffer);
            
            UIImageView *currProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xCoord, 0, profilePictureViewWidth, profilePictureViewWidth)];
            currProfileImageView.image = [UIImage imageNamed:@"testImage.jpg"];
            
            NSData *currData = [currObj[@"profilePicture"] getData];
            UIImage *pp = [UIImage imageWithData:currData];
            currProfileImageView.image = pp;
            [self.eventDetailsView.peopleGoingScrollView addSubview:currProfileImageView];
            
            finalWidth += profilePictureViewWidth;
            finalWidth += buffer;
        }
        finalWidth -= buffer;

        // update the scroll view size
        CGSize contentSize = CGSizeMake(finalWidth, self.eventDetailsView.peopleGoingScrollView.frame.size.height);
        self.eventDetailsView.peopleGoingScrollView.contentSize = contentSize;
        
    } else {
        NSLog(@"error populating scroll view");
    }
}

# pragma mark - add selectors
- (void) addSelectors {
    // selector for submit button
    [self.eventDetailsView.signUpForEventButton addTarget:self
                                           action:@selector(signUpButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.eventDetailsView.editEventButton addTarget:self
                                                   action:@selector(editButtonPressed:)
                                         forControlEvents:UIControlEventTouchUpInside];
}

# pragma mark - selectors
- (IBAction) signUpButtonPressed:(id)sender {
    NSLog(@"sign up button pressed");
    // update to database
    [self signUpDatabaseCall];
}

- (IBAction) editButtonPressed:(id)sender {
    NSLog(@"edit button pressed");
    // TODO: if have time
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
