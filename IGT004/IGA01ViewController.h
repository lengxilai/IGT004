//
//  IGA01ViewControllerViewController.h
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "IGBasicAnnotation.h"
@interface IGA01ViewControllerViewController : UIViewController <MKMapViewDelegate> {
    MKMapView *m_mkMapView;
    NSMutableArray *m_geoArray;
}

@end
