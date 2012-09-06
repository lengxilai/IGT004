//
//  IGLocationUtil.h
//  IGT004
//
//  Created by wang chong on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface IGLocationUtil : NSObject{
    
}
+(void)setUserLocation:(MKUserLocation *)location;
+(MKUserLocation *)getUserLocation;
@end
