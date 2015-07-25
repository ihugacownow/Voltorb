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

@interface DiscoverViewController () <AGSMapViewLayerDelegate, AGSMapViewTouchDelegate, AGSCalloutDelegate, CLLocationManagerDelegate>



@property (strong, nonatomic) AGSMapView *mapView;
@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSMutableArray *nearbyIssues;
@property (strong, nonatomic) AGSGraphicsLayer *myGraphicsLayer;
@property (strong, nonatomic) AGSTiledMapServiceLayer *tiledLayer;

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
    
    self.nearbyIssues = [NSMutableArray array];
    [self.nearbyIssues addObject:@"1"];
    [self.nearbyIssues addObject:@"2"];

    
//    [self.nearbyIssues addObject:(1.381905,103.844818)];
    
    
    
    
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



-(BOOL)callout:(AGSCallout*)callout willShowForFeature:(id<AGSFeature>)feature layer:(AGSLayer<AGSHitTestable>*)layer mapPoint:(AGSPoint*)mapPoint{
    //Specify the callout's contents
    self.mapView.callout.title = (NSString*)[feature attributeForKey:@"Name"];
    self.mapView.callout.detail =(NSString*)[feature attributeForKey:@"Address"];
//    mapView.callout.image = [UIImage imageNamed:@"<my_image.png>"];
    return YES;
}


//- (BOOL)callout:(AGSCallout *)callout willShowForLocationDisplay:(AGSLocationDisplay *)locationDisplay {
//    
//}

//- (void)setMapViewCalloutAppearance() {
//    self.mapView.callout
//}

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
    
    NSString* theString = [[NSString alloc] initWithFormat:@"xmin = %f,ymin =%f,xmax = %f,ymax = %f",
                           
                           self.mapView.visibleAreaEnvelope.xmin,
                           self.mapView.visibleAreaEnvelope.ymin,
                           self.mapView.visibleAreaEnvelope.xmax,
                           self.mapView.visibleAreaEnvelope.ymax];
    
    NSLog(@"The visible extent = %@", theString);
    
    
    
    
}

- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features {
    
    NSLog(@"%@", mappoint);
    self.mapView.callout.showCalloutForLocationDisplay;
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
    AGSPoint* lowerPointUpdated = (AGSPoint*)[engine projectGeometry:lowerPoint
                                       toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];


}



- (void)mapView:(AGSMapView *)mapView didMoveTapAndHoldAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mapView.frame = CGRectMake(0.00, 0.00, 700.00, 400.00);
    self.mapView.center = self.view.center;
    
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
        
    } else {
        NSLog(@"error in retrieving user issues");
    }
    
    return [[NSMutableArray alloc] init];
}

@end
