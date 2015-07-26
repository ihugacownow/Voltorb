//
//  ArchivedIssuesView.m
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "ArchivedIssuesView.h"

@interface ArchivedIssuesView ()

// top bar
@property (nonatomic, strong) UILabel *topBarName;

@end

@implementation ArchivedIssuesView

// override
- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self loadUI];
    }
    
    return self;
}

- (void) layoutSubviews {
    self.topBarName.frame = CGRectMake(0, 0, self.bounds.size.width, 50);
    
    self.tableViewForIssues.frame = CGRectMake(30, 100, self.bounds.size.width - 60, 400);
}

- (void) loadUI {
    [self loadTopBar];
    [self addSegmentedView];
    [self loadTableView];
}

- (void) loadTopBar {
    self.topBarName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.topBarName.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.8];
    self.topBarName.text = @"Issue Listings";
    self.topBarName.textColor = [UIColor whiteColor];
    self.topBarName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.topBarName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.topBarName];
}

- (void) loadTableView {
    self.tableViewForIssues = [[UITableView alloc] initWithFrame:CGRectZero];
//    self.tableViewForIssues.layer.borderColor = [UIColor blackColor].CGColor;
//    self.tableViewForIssues.layer.borderWidth = 1.0;
    self.tableViewForIssues.layer.cornerRadius = 7;
    self.tableViewForIssues.layer.masksToBounds = YES;
    [self addSubview:self.tableViewForIssues];
}

- (void) addSegmentedView {
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 435)];
    scroll.contentSize = CGSizeMake(320, 700);
    scroll.showsHorizontalScrollIndicator = YES;
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Old", @"Current", nil];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.segmentedControl.frame = CGRectMake(35, 60, 250, 30);
    [self.segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 1;
    [scroll addSubview:self.segmentedControl];
    [self addSubview:scroll];
    
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    UIColor *newTintColor = [UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.segmentedControl.tintColor = newTintColor;
    
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [[[self.segmentedControl subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        NSLog(@"inside old");
    } else {
        NSLog(@"inside current");
    }
    [self.tableViewForIssues reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
