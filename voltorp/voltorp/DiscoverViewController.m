//
//  DiscoverViewController.m
//  voltorp
//
//  Created by Wu Wai Choong on 25/7/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "DiscoverViewController.h"
#import <ArcGIS/ArcGIS.h>

@interface DiscoverViewController () <AGSMapViewLayerDelegate>



@property (strong, nonatomic) AGSMapView *mapView;
@property (strong, nonatomic) UITableView *listView;

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
