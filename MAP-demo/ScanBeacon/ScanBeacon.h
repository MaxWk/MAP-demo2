//
//  ScanBeacon.h
//  Attendance2
//
//  Created by LiuZhirui on 16/3/22.
//  Copyright © 2016年 Huami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SupportUUID.h"

@interface ScanBeacon : NSObject <CLLocationManagerDelegate>

@property (strong) NSArray *beaconsArray;

-(id)initWithuuid:(NSString*)uuid beaconIdentifier:(NSString*)identifier;

-(void)starscanBeacon:(double)scantime;

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region;

-(NSArray*)getBeaconArry;

@end
