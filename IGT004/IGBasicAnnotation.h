//
//  IGBasicAnnotation.h
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "IGGeoInfo.h"
#import "Restaurant.h"
@interface IGBasicAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    IGGEOInfo *m_geoInfo;
    Restaurant *res;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) IGGEOInfo *m_geoInfo;

-(id)initWithGeoInfo:(IGGEOInfo *) geoInfo;
- (NSString *)subtitle;
- (NSString *)title;
-(Restaurant *)restaurant;


@end
