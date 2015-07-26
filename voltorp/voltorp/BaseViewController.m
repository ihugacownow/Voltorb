//
//  BaseViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "BaseViewController.h"
#import "Themes.h"

@interface BaseViewController ()

@property (nonatomic) CGPoint originalCenter;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.originalCenter = CGPointMake(self.view.center.x, self.view.center.y);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wallpaper.jpg"]];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    return YES;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}



- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y - 100);
    
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    self.view.center = self.originalCenter;
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
