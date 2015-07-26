//
//  Themes.m
//  voltorp
//
//  Created by Ignatius Admin on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "Themes.h"

@implementation Themes

+(UIFont *)textFieldFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light"  size:16.00];
}

+(UIColor *)lightBlueBackground {
    return [UIColor colorWithRed:115 green:241 blue:255 alpha:1.00];
}

+(UIColor *)darkBlue {
    return [UIColor colorWithRed:21 green:144 blue:205 alpha:1];
}

+(UIFont *)textFieldBiggerFont {
    return [UIFont fontWithName:@"HelveticaNeue"  size:25.00];
}

@end
