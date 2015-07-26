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
#import "IssueTrackerViewController.h"
#import "Themes.h"
#import "IssueViewController.h"
#import "PostDiscTBController.h"
@import CoreLocation;

@interface DiscoverViewController () <AGSMapViewLayerDelegate, AGSMapViewTouchDelegate, AGSCalloutDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>



@property (strong, nonatomic) AGSMapView *mapView;
@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) AGSGraphicsLayer *myGraphicsLayer;
@property (strong, nonatomic) AGSTiledMapServiceLayer *tiledLayer;
@property (strong, nonatomic) NSMutableArray *allIssuesInView;
@property (strong, nonatomic) NSMutableArray *allIssues;
@property (strong, nonatomic) UIButton *createNewIssue;

//@property (strong, nonatomic)


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
    
    self.tiledLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url];
    
    [self.mapView addMapLayer:self.tiledLayer withName:@"BasemapLayer"];
    self.myGraphicsLayer =[AGSGraphicsLayer graphicsLayer];
    
    // Add Annotations
    [self addAnnotation];
    
    
    [self.mapView addMapLayer:self.myGraphicsLayer withName:@"Graphics Layer"];
    self.mapView.layerDelegate = self;
    self.mapView.touchDelegate = self;

    self.mapView.callout.title = @"Hello";
    self.mapView.allowCallout = YES;

    
    
    
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

    
    self.listView = [[UITableView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:self.listView];
    
    self.allIssuesInView = [NSMutableArray new];
    self.allIssuesInView = [self retrieveAllIssues];
    
    self.allIssues = [NSMutableArray new];
    self.allIssues = [self retrieveAllIssues];
    
 
    self.createNewIssue = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.createNewIssue setTitle:@"New Issue" forState:UIControlStateNormal];
    self.createNewIssue.titleLabel.font = [Themes textFieldFont];
    [self.createNewIssue addTarget:self action:@selector(goTocreateNewIssueVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createNewIssue];
}

- (void) goTocreateNewIssueVC {
    IssueViewController *vc = [[IssueViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) addAnnotation {
    
    CLLocation* gpsLocation = [[CLLocation alloc] initWithLatitude:1.370016 longitude:103.849449];
    CLLocation* gpsLocationTwo = [[CLLocation alloc] initWithLatitude:1.381905 longitude:103.844818];
    
    
    // create a AGSPoint from the GPS coordinates
    AGSPoint* gpsPoint = [[AGSPoint alloc] initWithX:gpsLocation.coordinate.longitude
                                                   y:gpsLocation.coordinate.latitude
                                    spatialReference:[AGSSpatialReference wgs84SpatialReference]];
    AGSPoint* gpsPointTwo = [[AGSPoint alloc] initWithX:gpsLocationTwo.coordinate.longitude
                                                      y:gpsLocationTwo.coordinate.latitude
                                       spatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    AGSGeometryEngine* engine = [AGSGeometryEngine defaultGeometryEngine];
    
    // convert GPS WGS-84 coordinates to the map's spatial reference
    // (assuming self.mapView is your AGSMapView for your map)
    AGSPoint* mapPoint = (AGSPoint*) [engine projectGeometry:gpsPoint toSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:3414 WKT:@"SVY21"]];
    
//    AGSPoint* mapPoint = (AGSPoint*) [engine projectGeometry:[gpsPoint
//                                          toSpatialReference: nil]
    
                                      
                                      
//                                                              : wkid =102100,wkt = null]];
    AGSPoint* mapPointTwo = (AGSPoint*) [engine projectGeometry:gpsPointTwo
                                             toSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:3414 WKT:@"SVY21"]];
    
    
    //create a marker symbol to be used by our Graphic
    AGSSimpleMarkerSymbol *myMarkerSymbol =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol.color = [UIColor blueColor];
    
    
    //Create the Graphic, using the symbol and
    //geometry created earlier
    AGSGraphic* myGraphic =
    [AGSGraphic graphicWithGeometry:mapPoint
                             symbol:myMarkerSymbol
                         attributes:nil];
    
    AGSGraphic* myGraphicTwo =
    [AGSGraphic graphicWithGeometry:mapPointTwo
                             symbol:myMarkerSymbol
                         attributes:nil];
    
    //Create an AGSPoint (which inherits from AGSGeometry) that
    //defines where the Graphic will be drawn
    AGSPoint* myMarkerPoint =
    [AGSPoint pointWithX:27602.530747
                       y:27592.624526
        spatialReference:self.mapView.spatialReference];
    
    //Create the Graphic, using the symbol and
    //geometry created earlier
    AGSGraphic* myGraphicThree =
    [AGSGraphic graphicWithGeometry:myMarkerPoint
                             symbol:myMarkerSymbol
                         attributes:nil];
    
    //Add the graphic to the Graphics layer
    [self.myGraphicsLayer addGraphic:myGraphicThree];
    
    
    //Add the graphic to the Graphics layer
    [self.myGraphicsLayer addGraphic:myGraphic];
    [self.myGraphicsLayer addGraphic:myGraphicTwo];
    

}

- (void) addInViewIssueAnnotationFromAllIssues {
    for (PFObject *issue in self.allIssuesInView) {

        AGSGeometryEngine* engine = [AGSGeometryEngine defaultGeometryEngine];

        // create a AGSPoint from the GPS coordinates
        AGSPoint* issuePoint = [[AGSPoint alloc] initWithX:((PFGeoPoint*) issue[@"location"]).longitude
                                                         y:((PFGeoPoint *) issue[@"location"]).latitude
                                          spatialReference:[AGSSpatialReference wgs84SpatialReference]];
        
        // convert GPS WGS-84 coordinates to the map's spatial reference
        // (assuming self.mapView is your AGSMapView for your map)
        AGSPoint* mapPoint = (AGSPoint*) [engine projectGeometry:issuePoint toSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:3414 WKT:@"SVY21"]];
        
        //create a marker symbol to be used by our Graphic
        AGSSimpleMarkerSymbol *myMarkerSymbol =
        [AGSSimpleMarkerSymbol simpleMarkerSymbol];
        myMarkerSymbol.color = [UIColor blueColor];
        
        //Create the Graphic, using the symbol and
        //geometry created earlier
        AGSGraphic* mapIssueGrpahic=
        [AGSGraphic graphicWithGeometry:mapPoint
                                 symbol:myMarkerSymbol
                             attributes:nil];
        
        
        //Add the graphic to the Graphics layer
        [self.myGraphicsLayer addGraphic:mapIssueGrpahic];
    }

}


- (void) addIssueAnnotationFrom:(NSMutableArray*) issues {
    for (PFObject *issue in issues) {
           // create a AGSPoint from the GPS coordinates
    AGSPoint* issuePoint = [[AGSPoint alloc] initWithX:((PFGeoPoint*) issue[@"location"]).longitude
                                                   y:((PFGeoPoint *) issue[@"location"]).latitude
                                    spatialReference:[AGSSpatialReference wgs84SpatialReference]];
    AGSGeometryEngine* engine = [AGSGeometryEngine defaultGeometryEngine];
    
    // convert GPS WGS-84 coordinates to the map's spatial reference
    // (assuming self.mapView is your AGSMapView for your map)
    AGSPoint* mapPoint = (AGSPoint*) [engine projectGeometry:issuePoint toSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:3414 WKT:@"SVY21"]];
  
    
    //create a marker symbol to be used by our Graphic
    AGSSimpleMarkerSymbol *myMarkerSymbol =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol.color = [UIColor blueColor];
    
    
    //Create the Graphic, using the symbol and
    //geometry created earlier
    AGSGraphic* mapIssueGrpahic=
    [AGSGraphic graphicWithGeometry:mapPoint
                             symbol:myMarkerSymbol
                         attributes:nil];
    
    
    //Add the graphic to the Graphics layer
    [self.myGraphicsLayer addGraphic:mapIssueGrpahic];
    }
}


- (void)mapViewDidLoad:(AGSMapView *) mapView {
    //do something now that the map is loaded
    //for example, show the current location on the map
    [mapView.locationDisplay startDataSource];
    
    // register for pan notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToEnvChange:)
                                                 name:AGSMapViewDidEndPanningNotification object:nil];
    
    // register for zoom notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToEnvChange:)
                                                 name:AGSMapViewDidEndZoomingNotification object:nil];
    
    
    
}

- (void)respondToEnvChange: (NSNotification*) notification {
    
    
    AGSEnvelope *envelope = self.mapView.visibleAreaEnvelope;
    AGSGeometryEngine* engine = [AGSGeometryEngine defaultGeometryEngine];
    
    
    AGSPoint* upperPoint = [[AGSPoint alloc] initWithX:envelope.xmax
                                                     y:envelope.ymax
                                      spatialReference:[AGSSpatialReference spatialReferenceWithWKID:3414 WKT:@"SVY21"]];
    AGSPoint *upperPointConverted = (AGSPoint*) [engine projectGeometry:upperPoint
                                                     toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    
    AGSPoint* lowerPoint = [[AGSPoint alloc] initWithX:envelope.xmin
                                                     y:envelope.ymin
                                      spatialReference:[AGSSpatialReference spatialReferenceWithWKID:3414 WKT:@"SVY21"]];
    AGSPoint* lowerPointConverted = (AGSPoint*)[engine projectGeometry:lowerPoint
                                                    toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    PFGeoPoint *swBound = (PFGeoPoint *) [PFGeoPoint geoPointWithLatitude:lowerPointConverted.y longitude:lowerPointConverted.x];
    
    PFGeoPoint *neBound = (PFGeoPoint *) [PFGeoPoint geoPointWithLatitude:upperPointConverted.y longitude:upperPointConverted.x];
    
//    PFGeoPoint *seBound = (PFGeoPoint *) [PFGeoPoint geoPointWithLatitude:lowerPointConverted.y longitude:upperPointConverted.x];
    
//    PFGeoPoint *seBound = (PFGeoPoint *) [PFGeoPoint geoPointWithLatitude:lowerPointConverted.y longitude:upperPointConverted.x];

    

    
    NSMutableArray *issues = [self retrieveIssuesInBoundaries:swBound withPoint:neBound];
    
    [self addIssueAnnotationFrom:issues];
    
    [self.listView reloadData];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mapView.frame = CGRectMake(0.00, 0.00, 300.00, 400.00);
    self.listView.frame = CGRectMake(0.00, 400.00, 300.00, 100.00);
    self.createNewIssue.frame = CGRectMake(250, 520, 50, 50);
    self.listView.dataSource = self;
    self.listView.delegate = self;
    
}

#pragma mark TableView datasource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allIssuesInView count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    

    cell.textLabel.text = [self.allIssuesInView objectAtIndex:indexPath.row][@"description"];
    cell.textLabel.textColor = [UIColor blackColor];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *passedUser = [self.allIssuesInView objectAtIndex:indexPath.row];
    [self goToSpecificIssueVC:passedUser];
  
  
}

-(void)goToSpecificIssueVC:(PFObject *)issue {
    
   
    IssueTrackerViewController *vc = [[IssueTrackerViewController alloc] init];
    
    
    PostDiscTBController *rc = [[PostDiscTBController alloc] init];
    rc.profileVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"test"] tag:1];
    rc.discoverVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Discover" image:[UIImage imageNamed:@"test"] tag:1];
    rc.listVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Archive" image:[UIImage imageNamed:@"test"] tag:1];
    
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;   
   
    [self presentViewController:vc animated:YES completion:^{
        vc.issue = issue;
        [vc updateState];
        [self.navigationController pushViewController:rc animated:NO];

    }];
    
    
    
    
    
    
//    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
//    NSLog(@"%@", self.currentLocation);
   
}




#pragma mark - Database calls


- (NSMutableArray *) retrieveAllIssues{
    NSLog(@"retrieving all issues");
    PFQuery *query = [PFQuery queryWithClassName:
                      @"Issue"];

    NSArray *pfo = [query findObjects];
    if ([pfo count]) {
        for (PFObject *obj in pfo) {
            NSLog(@"pf object is %@", obj);
            NSLog(@"current issue description is %@", obj[@"description"]);
            NSLog(@"current issue location is %@", obj[@"locationTuple"]);
            
        }
        
        return [pfo mutableCopy];
        
    } else {
        NSLog(@"error in retrieving user issues");
    }
    
    
    return [[NSMutableArray alloc] init];
;
}

//- (NSMutableArray *)getIssuesWithin:(NSMutableArray *)IssuesArray inbetween: (AGSPoint *)swBound and:(AGSPoint *)neBound  {
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.data.squareFootage.intValue >= %d", [filterSquareFootage intValue]];
//    return nil;
//     
// }



- (NSMutableArray *) retrieveIssuesInBoundaries:(PFGeoPoint *)swBound withPoint:(PFGeoPoint *)neBound {
    NSLog(@"retrieving issues within boundaries");
    PFQuery *query = [PFQuery queryWithClassName:
                      @"Issue"];
    [query whereKey: @"location" withinGeoBoxFromSouthwest:swBound toNortheast:neBound];
    
    NSArray *pfo = [query findObjects];
    if ([pfo count]) {
        /*for (PFObject *obj in pfo) {
         NSLog(@"pf object is %@", obj);
         NSLog(@"current issue description is %@", obj[@"description"]);
         NSLog(@"current issue location is %@", obj[@"locationTuple"]);
         
         }*/
        return [pfo mutableCopy];
        
    } else {
        NSLog(@"error in retrieving user issues");
    }
    
    
    return [[NSMutableArray alloc] init];
    
}

@end
