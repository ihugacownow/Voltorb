//
//  CustomCell.m
//  voltorp
//
//  Created by Ignatius Admin on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.iconView = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.iconView setBackgroundImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
        
        self.countView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.countView.text = @"1";
        
    
        [self addSubview:self.iconView];
        [self addSubview:self.countView];
    }
    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
//    [self addSubview:self.iconView];
//    [self addSubview:self.countView];
    self.iconView.frame = CGRectMake(self.textLabel.bounds.size.width + 50, 0, 60, 60);
    self.countView.frame = CGRectMake(self.textLabel.bounds.size.width + 80,0, 30, 30);
}

@end
