//
//  IGGEOInfo.h
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"
@interface IGGEOInfo : NSObject{
    NSInteger m_id;
    NSString *m_name;
    NSString *m_description;
    NSString *m_imageName;
    Restaurant *res;
    CLLocationCoordinate2D m_coordinate2D;
}

@property (nonatomic, readwrite) NSInteger m_id;
@property (nonatomic, retain) NSString *m_name;
@property (nonatomic, retain) NSString *m_description;
@property (nonatomic, retain) NSString *m_imageName;
@property (nonatomic, readwrite) CLLocationCoordinate2D m_coordinate2D;
@property (nonatomic, retain) Restaurant *res;


@end
