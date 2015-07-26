//
//  IssueCreationMapViewController.m
//  voltorp
//
//  Created by Ignatius Admin on 7/26/15.
//  Copyright (c) 2015 Yeohmen. All rights reserved.
//

#import "IssueCreationMapViewController.h"
#import <ArcGIS/ArcGIS.h>
#import <Parse/Parse.h>
#import "Themes.h"

@import CoreLocation;

@interface IssueCreationMapViewController ()




@property (strong, nonatomic) AGSMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) AGSGraphicsLayer *myGraphicsLayer;
@property (strong, nonatomic) AGSTiledMapServiceLayer *tiledLayer;

@end

@implementation IssueCreationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Create New Issue" image:[UIImage imageNamed:@"test"] selectedImage:[UIImage imageNamed:@"test"]];
    
    //Add a basemap tiled layer
    NSURL* url = [NSURL URLWithString:@"http://e1.onemap.sg/arcgis/rest/services/SM128/MapServer"];
    
    // Map View
    self.mapView = [[AGSMapView alloc] initWithFrame:CGRectZero];
    
    self.tiledLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url];
    
    [self.mapView addMapLayer:self.tiledLayer withName:@"BasemapLayer"];
    self.myGraphicsLayer =[AGSGraphicsLayer graphicsLayer];
    
    // Add Annotations
    /* add pin*/
    
    
    [self.mapView addMapLayer:self.myGraphicsLayer withName:@"Graphics Layer"];
    self.mapView.layerDelegate = self;
    self.mapView.touchDelegate = self;
    
    self.mapView.callout.title = @"Hello";
    self.mapView.allowCallout = YES;
    
    
    
    
    [self.view addSubview:self.mapView];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    
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

-(void)mapView:(AGSMapView*)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features {
    [self addAnnotation:mappoint];
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mapView.frame = CGRectMake(0.00, 0.00, self.view.frame.size.width, self.view.frame.size.height);
    
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
    
    
    
    
    
}

-(void) addAnnotation:(AGSPoint *) touchPoint {
        //create a marker symbol to be used by our Graphic
    AGSSimpleMarkerSymbol *myMarkerSymbol =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol.color = [UIColor blueColor];
    
    
    //Create the Graphic, using the symbol and
    //geometry created earlier
    AGSGraphic* myGraphic =
    [AGSGraphic graphicWithGeometry:touchPoint
                             symbol:myMarkerSymbol
                         attributes:nil];
    
    
    //Add the graphic to the Graphics layer
    [self.myGraphicsLayer removeAllGraphics];
    [self.myGraphicsLayer addGraphic:myGraphic];
    
//    AGSLocator * agsLocator = [[AGSLocator alloc] init];
//    AGSJSONRequestOperation * reverseGeocode = (AGSJSONRequestOperation *)[agsLocator addressForLocation:touchPoint maxSearchDistance:5.0];
//    [reverseGeocode completionHandler: (id *) result {
//    
//    }];
    
    float longitude = touchPoint.x;
    float latitude = touchPoint.y;
    NSString *oneMapToken = @"AHKQjAFL4Pl1Y+o2r7FSgTURV/IIoMCsxNoTgHDqZ0izmRsruQtNddCrtIg9mbm67rbeddqzNJ1DCyL9LzGe7iVeuv14yn1O";
    NSString *url = @"https://www.onemap.sg/API/services.svc/revgeocode?token=AHKQjAFL4Pl1Y+o2r7FSgTURV/IIoMCsxNoTgHDqZ0izmRsruQtNddCrtIg9mbm67rbeddqzNJ1DCyL9LzGe7iVeuv14yn1O&location=";
    url = [NSString stringWithFormat:@"%@%f,%f", url, longitude, latitude];
    NSData *jsonDataString = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding: NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;

    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonDataString options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error: &error];
    
    NSArray *myResults = [results valueForKeyPath:@"GeocodeInfo"];
    NSString * postalCode = myResults[0][@"POSTALCODE"];
    NSLog(@"%@", postalCode);
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
