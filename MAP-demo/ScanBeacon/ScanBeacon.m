//
//  ScanBeacon.m
//  Attendance2
//
//  Created by LiuZhirui on 16/3/22.
//  Copyright © 2016年 Huami. All rights reserved.
//

#import "ScanBeacon.h"
#import <UIKit/UIKit.h>


@interface ScanBeacon () 

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSUUID *beacconUUID;
@property (strong,nonatomic)  NSString *beaconIdentifier;

@end


@implementation ScanBeacon

BOOL requestopenLM = true;


-(id)initWithuuid:(NSString*)uuid beaconIdentifier:(NSString*)identifier
{
    self = [super init];
    if(self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.beacconUUID= [[NSUUID alloc] initWithUUIDString:
                           uuid];
        NSLog(@"uuid:%@",uuid);
        self.beaconIdentifier = identifier;
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:
                             self.beacconUUID identifier:self.beaconIdentifier];
        if([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
        {
            [self.locationManager requestAlwaysAuthorization];
        }
        
    }
    return self;
}

-(void)starscanBeacon:(double)scantime
{
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
    {
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
        {
            self.locationManager.pausesLocationUpdatesAutomatically = NO;
            [self.locationManager startMonitoringForRegion:self.beaconRegion];
            [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
            [self.locationManager startUpdatingLocation];
            [self performSelector:@selector(stopScanning) withObject:nil afterDelay:scantime];
        }
        NSLog(@"start");

    }
    else if ([[[UIDevice currentDevice]systemVersion]floatValue]<8.0)
    {
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
        [self.locationManager startUpdatingLocation];
        [self performSelector:@selector(stopScanning) withObject:nil afterDelay:scantime];
    }
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    self.beaconsArray = beacons;
    NSLog(@"beacon:%@", self.beaconsArray);
}

-(void)stopScanning
{
    NSLog(@"stop");
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    
}
-(NSArray*)getBeaconArry
{
    return self.beaconsArray;
}
@end
