//
//  CustomTextField.m
//  voltorp
//
//  Created by Wu Wai Choong on 26/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "CustomTextField.h"
#import "Themes.h"

@implementation CustomTextField


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bottomLine = [[UIView alloc] initWithFrame:frame];
        self.bottomLine.backgroundColor = [UIColor blackColor];
        self.bottomLine.backgroundColor = [Themes lightBlueBackground];
        
        self.font = [Themes textFieldFont];

        [self addSubview:self.bottomLine];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 2);
    
}


@end
