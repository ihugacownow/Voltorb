//
//  IssueTrackerViewController.m
//  voltorp
//
//  Created by Lianhan Loh on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueTrackerViewController.h"
#import "IssueTrackerView.h"

@interface IssueTrackerViewController ()

@property (strong, nonatomic) IssueTrackerView *issueTrackerView;

@end

@implementation IssueTrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.issueTrackerView = [[IssueTrackerView alloc] initWithFrame: CGRectZero];
    [self.view addSubview: self.issueTrackerView];
    // TODO: not hard code
    [self loadPostsForIssueWithObjectID:@"A7kRuIglWL"];
    // Do any additional setup after loading the view.
}

- (void) viewDidLayoutSubviews {
    self.issueTrackerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadPostsForIssueWithObjectID: (NSString *) objectID {
    
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
    
    // initialize scroll view
    self.issueTrackerView.postsScrollView.pagingEnabled = NO;

    int xOffset = 30;
    int yOffSet = 0;
    int finalHeight = 0;
    int buffer = 5;
    // list posts
//    for (int i = 0; i < 1; i++) {
        UIImageView *currProfileImageView = [[UIImageView alloc] initWithFrame: CGRectMake(xOffset, yOffSet + 5, 20, 20)];
        NSLog(@"added one picture");
        currProfileImageView.image = [UIImage imageNamed: @"verified.png"];
//        currProfileImageView.image = posts[i][@"userPic"];
//        NSLog(@"%@", posts[i][@"username"]);
        [self.issueTrackerView.postsScrollView addSubview: currProfileImageView];
        
        UILabel *name = [[UILabel alloc] initWithFrame: CGRectMake(xOffset, yOffSet + 25, 40, 10)];
        name.text = @"Ignatius";
        [self.issueTrackerView.postsScrollView addSubview: name];
        finalHeight += 40;
        finalHeight += buffer;
//    }
    finalHeight -= buffer;
    
    // update the scroll view size
    CGSize contentSize = CGSizeMake(self.issueTrackerView.postsScrollView.frame.size.width, finalHeight);
    self.issueTrackerView.postsScrollView.contentSize = contentSize;

    
//    UIImageView *currProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xCoord, 0, profilePictureViewWidth, profilePictureViewWidth)];
//    currProfileImageView.image = [UIImage imageNamed:@"testImage.jpg"];
//    
//    NSData *currData = [currObj[@"profilePicture"] getData];
//    UIImage *pp = [UIImage imageWithData:currData];
//    currProfileImageView.image = pp;
//    [self.eventDetailsView.peopleGoingScrollView addSubview:currProfileImageView];
//    
//    finalWidth += profilePictureViewWidth;
//    finalWidth += buffer;
    
}

#pragma mark - database query

- (void) databaseQuery {
    
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
