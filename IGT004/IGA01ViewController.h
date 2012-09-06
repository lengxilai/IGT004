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
#import "IGCoreDataUtil.h"
#import "IGMapAnnotationView.h"
#import "IGCommonDefine.h"
#import "IGLocationUtil.h"
@interface IGA01ViewController : UIViewController <MKMapViewDelegate,NSFetchedResultsControllerDelegate,UISearchBarDelegate>  {
    MKMapView *m_mkMapView;
    NSMutableArray *m_geoArray;
    double m_locationLatitude;
    double m_locationLongitude;
    UISearchBar *m_searchBar;
    //结果集管理器
    NSFetchedResultsController *fetchedResultsController;
}


@end
