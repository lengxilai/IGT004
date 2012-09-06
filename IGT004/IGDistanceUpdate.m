//
//  IGDistanceUpdate.m
//  IGT004
//
//  Created by Ming Liu on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGDistanceUpdate.h"

@implementation IGDistanceUpdate
+(void)updateDistance
{
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nil];
    NSArray *results = [IGCoreDataUtil queryForArray:@"Restaurant" queryCondition:nil sortDescriptors:sortDescriptors];

    MKUserLocation *userLocation = [IGLocationUtil getUserLocation];
    CLLocation *location = userLocation.location;
    if (results != nil) {
        for (Restaurant *r in results) {
            NSString *latitude = r.latitude;
            NSString *longitude = r.longitude;
            
            CLLocation * targetLocation = [[CLLocation alloc]initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue] ]; 
            CLLocationDistance distance = [location distanceFromLocation:targetLocation];
            r.distance = [NSNumber numberWithDouble:distance];
        }
    }
    [[IGCoreDataUtil getStaticManagedObjectContext] save:nil];
}
@end
