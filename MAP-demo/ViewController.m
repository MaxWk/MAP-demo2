//
//  ViewController.m
//  MAP-demo
//
//  Created by MAX_W on 16/4/27.
//  Copyright © 2016年 MAX_W. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ViewController.h"



@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,strong) MKMapView * mapView;
@property(nonatomic,assign) __block CLLocationCoordinate2D preCoord;
@property(nonatomic,assign) __block CLLocationCoordinate2D curCoord;

@end

@implementation ViewController

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    UIButton *start = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 50, 50)];
    start.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    start.layer.cornerRadius = 8;
    start.layer.masksToBounds = YES;
    [start setTitle:@"Start" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startDraw) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:start];
    
    UIButton *stop = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 50, 50, 50)];
    stop.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    stop.layer.cornerRadius = 8;
    stop.layer.masksToBounds = YES;
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopDraw) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:stop];
    
    UIButton *clear = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT-50, 50, 50)];
    clear.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    clear.layer.cornerRadius = 8;
    clear.layer.masksToBounds = YES;
    [clear setTitle:@"clear" forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearRoute) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:clear];

}

- (void)startDraw
{
    [_locationManager startUpdatingLocation];
}

- (void)stopDraw
{
    [_locationManager stopUpdatingLocation];
}

- (void)clearRoute
{
    [_mapView removeOverlays:_mapView.overlays];
}


- (void)updateRouteView
{
    CLLocationCoordinate2D group[2] = {_preCoord,_curCoord};
    MKPolyline *cc = [MKPolyline polylineWithCoordinates:group count:2];
    [_mapView addOverlay:cc];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineView *lineview = [[MKPolylineView alloc] initWithOverlay:overlay];
        //路线颜色
        lineview.strokeColor = [UIColor colorWithRed:0.0 green:126.0/255 blue:1.0 alpha:.75];
        lineview.lineWidth = 12.0;
        return lineview;
    }
    return nil;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    CLLocation *lastLocation = locations[locations.count-1];
    [self updateRouteView];
    _preCoord = _curCoord;
    _curCoord = lastLocation.coordinate;
//    [_locationManager stopUpdatingLocation];
    
}





@end
