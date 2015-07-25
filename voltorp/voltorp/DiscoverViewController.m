//
//  DiscoverViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "DiscoverViewController.h"
#import <ArcGIS/ArcGIS.h>
#import <Parse/Parse.h>
@import CoreLocation;

@interface DiscoverViewController () <AGSMapViewLayerDelegate, AGSMapViewTouchDelegate, CLLocationManagerDelegate>



@property (strong, nonatomic) AGSMapView *mapView;
@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSMutableArray *nearbyIssues;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Discover" image:[UIImage imageNamed:@"test"] selectedImage:[UIImage imageNamed:@"test"]];
    
    //Add a basemap tiled layer
    NSURL* url = [NSURL URLWithString:@"http://e1.onemap.sg/arcgis/rest/services/SM128/MapServer"];
    
    // Map View
    self.mapView = [[AGSMapView alloc] initWithFrame:CGRectZero];
    
    AGSTiledMapServiceLayer *tiledLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url];
    [self.mapView addMapLayer:tiledLayer withName:@"Basemap Tiled Layer"];
    self.mapView.layerDelegate = self;

    [self.view addSubview:self.mapView];
    
    self.listView = [[UITableView alloc] initWithFrame:CGRectZero];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.nearbyIssues = [NSMutableArray array];
    [self.nearbyIssues addObject:(1.381905,103.844818)];
    
    
    
    
}

- (void)mapViewDidLoad:(AGSMapView *) mapView {
    //do something now that the map is loaded
    //for example, show the current location on the map
    [mapView.locationDisplay startDataSource];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mapView.frame = CGRectMake(0.00, 0.00, 300.00, 200.00);
    self.mapView.center = self.view.center;
    
}

#pragma mark Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    NSLog(@"%@", self.currentLocation);
   
}




#pragma mark - Database calls


- (NSMutableArray *) retrieveIssuesByUser:(NSString *) userObjectID {
    NSLog(@"retrieving issues posted by user %@", userObjectID);
    
    PFQuery *query = [PFQuery queryWithClassName:
                      @"Issue"];
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

@end
