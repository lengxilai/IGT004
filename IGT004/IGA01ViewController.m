//
//  IGA01ViewControllerViewController.m
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA01ViewController.h"

@interface IGA01ViewController ()

@end

@implementation IGA01ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView{

    self.navigationItem.title = @"舌尖上的大连";
    
    self.view = [[UIView alloc] initWithFrame: CGRectMake(0, 20, 320, 480)];
    
    m_mkMapView = [[MKMapView alloc] initWithFrame: CGRectMake(0, 0, 320, 460)];
    m_mkMapView.delegate = self;
    m_mkMapView.showsUserLocation=TRUE;
    //创建位置管理器
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //设置代理
    locationManager.delegate=self;
    //指定需要的精度级别
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //设置距离筛选器
    locationManager.distanceFilter=1000.0f;
    //启动位置管理器
    [locationManager startUpdatingLocation]; 
    MKCoordinateSpan theSpan;
    //地图的范围 越小越精确
    theSpan.latitudeDelta=0.05;
    theSpan.longitudeDelta=0.05; 
    //MKCoordinateRegion region = {{40.976002, 116.317577}, {0.016, 0.016}};
    MKCoordinateRegion region;
    region.center = [[locationManager location] coordinate]; 
    region.span = theSpan;
    m_mkMapView.region = region;
    [self.view addSubview: m_mkMapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation: (id <MKAnnotation>)annotation
{
    NSLog(@"%s %d, annotation = %@", __FUNCTION__, __LINE__, annotation);
    
    if ([annotation isKindOfClass: [MKUserLocation class]]) // showsUserLocation
    {
        return nil;
    }
    
    IGBasicAnnotation *basicAnnotation = (IGBasicAnnotation *)annotation;
    MKAnnotationView *mkAnnotationView;
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"annotationView"];
    annotationView.userInteractionEnabled = YES;
    annotationView.alpha = 0.9;
    annotationView.canShowCallout = TRUE;
    
    mkAnnotationView = annotationView;
    
    
    UIButton *addButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    addButton.tag = basicAnnotation.m_geoInfo.m_id;
    [addButton addTarget:self action:@selector(showCompanyDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    return mkAnnotationView;
    
}

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"%s %d, views = %@", __FUNCTION__, __LINE__, views);
    
}

// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%s %d, view = %@, control = %@", __FUNCTION__, __LINE__, view, control);
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation    fromLocation:(CLLocation *)oldLocation {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init]; 
    if ([CLLocationManager locationServicesEnabled]) { 
        NSLog( @"Starting CLLocationManager" ); 
        locationManager.delegate = self; 
        locationManager.distanceFilter = 200; 
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
        [locationManager startUpdatingLocation]; 
    } else { 
        NSLog( @"Cannot Starting CLLocationManager" ); 
        /*self.locationManager.delegate = self; 
         self.locationManager.distanceFilter = 200; 
         locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
         [self.locationManager startUpdatingLocation];*/ 
    }
    MKCoordinateSpan theSpan; 
    //设置地图的范围，越小越精确 
    theSpan.latitudeDelta = 0.02; 
    theSpan.longitudeDelta = 0.02; 
    MKCoordinateRegion theRegion; 
    theRegion.center = [[locationManager location] coordinate]; //让地图跳到之前获取到的当前位置checkinLocation 
    theRegion.span = theSpan;
    [m_mkMapView setRegion:theRegion];
}

@end
