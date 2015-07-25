//
//  IssueTrackerViewController.m
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueTrackerViewController.h"
#import "IssueTrackerView.h"
#import <Parse/Parse.h>

@interface IssueTrackerViewController ()

@property (strong, nonatomic) IssueTrackerView *issueTrackerView;

@end

@implementation IssueTrackerViewController
{
    NSArray *issueDiscussionThread;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.issueTrackerView = [[IssueTrackerView alloc] initWithFrame: CGRectZero];
    [self.view addSubview: self.issueTrackerView];
    
    [self.issueTrackerView.postsTableView setDelegate:self];
    [self.issueTrackerView.postsTableView setDataSource:self];
    
    // TODO: not hard code
    [self retrieveEventDetailsWithObjectID:@"A7kRuIglWL"];
    [self retrieveAssociatedEventsForThisIssueOfObjectID:@"A7kRuIglWL"];
    
    [self addSelectors];
    // Do any additional setup after loading the view.
}

- (void) viewDidLayoutSubviews {
    self.issueTrackerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - database queries
- (void) retrieveEventDetailsWithObjectID:(NSString *) objectID {
    PFQuery *query = [PFQuery queryWithClassName:@"Issue"];
    [query whereKey:@"objectId" equalTo:objectID];
    
    NSArray *results = [query findObjects];
    if ([results count]) {
        PFObject *pfo = [results objectAtIndex:0];
        self.issueTrackerView.descriptionLabel.text = pfo[@"description"];
        issueDiscussionThread = pfo[@"discussionThread"];
        
    } else {
        NSLog(@"error retrieving event details with ID %@", objectID);
    }
}

- (void) retrieveAssociatedEventsForThisIssueOfObjectID:(NSString *) objectID {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"issueObjectID" equalTo:objectID];
    
    NSArray *results = [query findObjects];
    if ([results count]) {
        PFObject *pfo = [results objectAtIndex:0];
        self.issueTrackerView.eventDetails.text = pfo[@"eventName"];
        // TODO: create gesture recognizer to transit to event listing
        
    } else {
        self.issueTrackerView.eventDetails.text = @"No next steps planned.";
    }
}

# pragma mark - populating table view (delegate)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [issueDiscussionThread count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [issueDiscussionThread objectAtIndex:indexPath.row][1];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    
    NSString *userObjectID = [issueDiscussionThread objectAtIndex:indexPath.row][0];
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:userObjectID];
    NSArray *results = [query findObjects];
    PFObject *pfo = [results objectAtIndex:0];
    NSData *currData = [pfo[@"profilePhoto"] getData];
    if (currData) {
        UIImage *pp = [UIImage imageWithData:currData];
        cell.imageView.image = pp;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"verified.png"];
    }
    
    return cell;
}

# pragma mark - add selectors
- (void) addSelectors {
    // selector for submit button
    [self.issueTrackerView.proposeNewEventButton addTarget:self
                                                    action:@selector(proposeNewEventButtonPressed:)
                                          forControlEvents:UIControlEventTouchUpInside];
    
}

# pragma mark - selectors
- (IBAction )proposeNewEventButtonPressed:(id)sender {
    NSLog(@"segue to create new event now!");
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
