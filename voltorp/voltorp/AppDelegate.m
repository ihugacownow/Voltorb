//
//  AppDelegate.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "RootViewController.h"
#import "ChatViewController.h" 
#import "EventDetailsViewController.h"
#import "CheckInViewController.h" 
#import "DiscoverViewController.h" 
#import "SignUpViewController.h" 
#import "ProfileViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"QHOci6GGIOsyooGKnB9XwEWDMPtBkSqofgkqyX8u"
                  clientKey:@"UPdHLB3qeW58DFKzcDIYtWK4rqPW2a1NhH5xS9xT"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    ChatViewController *vcOne = [[ChatViewController alloc] init];
//    vcOne.view.backgroundColor = 
    EventDetailsViewController *vcTwo = [[EventDetailsViewController alloc] init];
    CheckInViewController *vcFour = [[CheckInViewController alloc] init];
    
//    NSArray *controllers = [NSArray arrayWithObjects:vcOne, vcTwo, vcThree, vcFour, nil];
//    for (UIViewController *vc in controllers) {
//        vc.view.backgroundColor = [UIColor whiteColor];
//    }
    
//    self.tabBarController.viewControllers = controllers;
    
    
    self.window.rootViewController = [[DiscoverViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
