//
//  ArchivedIssuesView.h
//  voltorp
//
//  Created by Jevon Yeoh on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivedIssuesView : UIView

// table view
@property (nonatomic, strong) UITableView *tableViewForIssues;

// segmented view
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end
