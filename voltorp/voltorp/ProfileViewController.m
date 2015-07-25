//
//  ProfileViewController.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/25/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import <Parse/Parse.h>

@interface ProfileViewController () 

@property (nonatomic, strong) ProfileView *profileView;
@property (nonatomic, strong) NSString *objectIDToLoad; //TODO: need to figure out where to get this from

@end

@implementation ProfileViewController
{
    NSArray *tableData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.objectIDToLoad = @"rghzVlOB8Z"; // TODO: for development

    
    self.profileView = [[ProfileView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.profileView];
    
    NSMutableDictionary *userData = [self getUserData:self.objectIDToLoad];
    self.profileView.nameLabel.text = [userData objectForKey:@"usersName"];
    self.profileView.locationLabel.text = [userData objectForKey:@"usersLocation"];
    
    tableData = @[@"1", @"2"];
    
    [self.profileView.issuesTableView setDelegate:self];
    [self.profileView.issuesTableView setDataSource:self];
    
    
    // TESTING HERE
    NSMutableArray *test = [self retrieveIssuesByUser:self.objectIDToLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    // set view here
    self.profileView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

# pragma mark - database call
- (NSMutableDictionary *) getUserData:(NSString *) userObjectID {
    NSLog(@"finding data for user with object id %@", userObjectID);
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:userObjectID];

    NSArray *pfo = [query findObjects];
    if ([pfo count]) {
        PFObject *results = [pfo objectAtIndex:0];
        NSMutableArray *dataValue = [[NSMutableArray alloc] init];
        NSString *name = [NSString stringWithFormat:@"%@ %@", results[@"firstName"], results[@"lastName"]];
        [dataValue addObject:name];
        [dataValue addObject:results[@"homeDistrict"]];
        NSArray *dataKeys = @[@"usersName", @"usersLocation"];
        NSMutableDictionary *output = [[NSMutableDictionary alloc] initWithObjects:dataValue forKeys:dataKeys];
        return output;
    } else {
        NSLog(@"error in retrieving user data");
        return nil;
    }
}

- (NSMutableArray *) retrieveIssuesByUser:(NSString *) userObjectID {
    NSLog(@"retrieving issues posted by user %@", userObjectID);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Issue"];
    [query whereKey:@"createdBy" equalTo:userObjectID];
    
    
    NSArray *pfo = [query findObjects];
    if ([pfo count]) {
        for (PFObject *obj in pfo) {
            NSLog(@"description is %@", [obj objectForKey:@"description"]);
            NSLog(@"status is %@", [obj objectForKey:@"status"]);
        }
        
    } else {
        NSLog(@"error in retrieving user issues");
    }
    
    return [[NSMutableArray alloc] init];
}

# pragma mark - populating table view (delegate)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
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
