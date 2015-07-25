//
//  ArchivedIssuesViewController.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "ArchivedIssuesViewController.h"
#import "ArchivedIssuesView.h"
#import <Parse/Parse.h>

@interface ArchivedIssuesViewController ()

@property (nonatomic, strong) ArchivedIssuesView *archivedIssuesView;

@end

@implementation ArchivedIssuesViewController
{
    NSMutableArray *oldIssues;
    NSMutableArray *newIssues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.archivedIssuesView = [[ArchivedIssuesView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:self.archivedIssuesView];
    
    [self.archivedIssuesView.tableViewForIssues setDelegate:self];
    [self.archivedIssuesView.tableViewForIssues setDataSource:self];
    
    oldIssues = [[NSMutableArray alloc] init];
    newIssues = [[NSMutableArray alloc] init];
    
    [self retrieveAllIssues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    // set view here
    self.archivedIssuesView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

# pragma mark - populating table view (delegate)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.archivedIssuesView.segmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"segmented control is 1");
        return [newIssues count];
    } else {
        NSLog(@"segmented control is 0");
        return [oldIssues count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (self.archivedIssuesView.segmentedControl.selectedSegmentIndex == 1) {
        cell.textLabel.text = [newIssues objectAtIndex:indexPath.row][@"description"];

        NSData *currData = [[newIssues objectAtIndex:indexPath.row][@"issuePhoto"] getData];
        if (currData) {
            UIImage *pp = [UIImage imageWithData:currData];
            cell.imageView.image = pp;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"verified.png"];
        }

    } else {
        cell.textLabel.text = [oldIssues objectAtIndex:indexPath.row][@"description"];

        NSData *currData = [[oldIssues objectAtIndex:indexPath.row][@"issuePhoto"] getData];
        if (currData) {
            UIImage *pp = [UIImage imageWithData:currData];
            cell.imageView.image = pp;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"verified.png"];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.archivedIssuesView.segmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"segmented control is 1 selected");
        // TODO: load issue with [newIssues objectAtIndex:indexPath.row][@"objectId"]
    } else {
        NSLog(@"segmented control is 0 selected");
        // TODO: load issue with [oldIssues objectAtIndex:indexPath.row][@"objectId"]
    }
}

# pragma mark - database query
- (void) retrieveAllIssues {
    PFQuery *query = [PFQuery queryWithClassName:@"Issue"];
    NSArray *results = [query findObjects];
    
    // split into old and new
    for (PFObject *obj in results) {
        NSString *status = obj[@"issueStatus"];
        if ([status isEqualToString:@"Completed"]) {
            [oldIssues addObject:obj];
        } else {
            [newIssues addObject:obj];
        }
    }
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
