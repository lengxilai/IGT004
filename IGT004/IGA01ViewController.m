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
#pragma mark -
#pragma mark Initialization
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
    m_mkMapView.showsUserLocation=YES;
    //    //创建位置管理器
    //    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //    //设置代理
    //    locationManager.delegate=self;
    //    //指定需要的精度级别
    //    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //    //设置距离筛选器
    //    locationManager.distanceFilter=1000.0f;
    //    //启动位置管理器
    //    [locationManager startUpdatingLocation]; 
    //    MKCoordinateSpan theSpan;
    //    //地图的范围 越小越精确
    //    theSpan.latitudeDelta=0.05;
    //    theSpan.longitudeDelta=0.05; 
    //    MKCoordinateRegion region;
    //    region.center = [[locationManager location] coordinate]; 
    //    region.span = theSpan;
    //    m_mkMapView.region = region;
    [self.view addSubview: m_mkMapView];
}

- (void)viewDidLoad
{
    
    [self getRestaurantList];
    //初始化所有餐厅信息
    for (IGGEOInfo *geoInfo in m_geoArray){
        IGBasicAnnotation *basicAnnotation = [[IGBasicAnnotation alloc] initWithGeoInfo:geoInfo];
        
        [m_mkMapView addAnnotation: basicAnnotation];
    }
	// Do any additional setup after loading the view.
    [super viewDidLoad];
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
#pragma mark -
#pragma mark map 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation: (id <MKAnnotation>)annotation
{
    NSLog(@"%s %d, annotation = %@", __FUNCTION__, __LINE__, annotation);
    
    if ([annotation isKindOfClass: [MKUserLocation class]]) // showsUserLocation
    {
        return nil;
    }
    
    IGBasicAnnotation *basicAnnotation = (IGBasicAnnotation *)annotation;
    MKAnnotationView *mkAnnotationView;
    IGMapAnnotationView *annotationMapView = [[IGMapAnnotationView alloc] initWithAnnotation:annotation];
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"annotationView"];
    annotationView.userInteractionEnabled = YES;
    annotationView.alpha = 0.9;
    annotationView.canShowCallout = TRUE;
    //annotationView.image = [UIImage imageNamed:@"logo.jpg"];
    //    [annotationView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.jpg"]]];
    
    [annotationView addSubview:annotationMapView];
    mkAnnotationView = annotationView;
    
    
    UIButton *addButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    addButton.tag = basicAnnotation.m_geoInfo.m_id;
    [addButton addTarget:self action:@selector(showCompanyDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    return mkAnnotationView;
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0){
    //吴嘉宾调用
    NSLog(@"ddd");
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

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
    
    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
    
    m_locationLatitude=[lat doubleValue];
    
    m_locationLongitude=[lng doubleValue];
    
    MKCoordinateSpan span;
    
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.010;
    
    span.longitudeDelta=0.010;
    
    region.span=span;
    
    region.center=[userLocation coordinate];
    
    [m_mkMapView setRegion:[m_mkMapView regionThatFits:region] animated:YES];
}

#pragma mark -
#pragma mark data
-(void)getRestaurantList{
    m_geoArray = [[NSMutableArray alloc] init];
    
    //    id<PLResultSet> result;
    //	result = [g_plDatabase executeQuery: @"Select ID, Name, Description, ImageName, Latitude, Longitude from GeoInfo"];
    //	
    //	while([result next])
    //    {
    IGGEOInfo *geoInfo = [[IGGEOInfo alloc] init];
    
    geoInfo.m_id = 1111;
    //geoInfo.m_name = @"test";
    
    NSLog(@"Adding %@ to m_geoArray", geoInfo.m_name);
    
    // geoInfo.m_description = @"yamede";
    
    CLLocationDegrees latitude = 37.7858;
    CLLocationDegrees longitude = -122.406;
    
    CLLocationCoordinate2D coordinate2D = {latitude, longitude};
    geoInfo.m_coordinate2D = coordinate2D;
    
    [m_geoArray addObject: geoInfo];
    //    }
    
    //    [result close];
}
#pragma mark -
#pragma mark 其他计算
-(double)getdistanceFromLocationWithLongitude:(double)newLongitude withLongitud:(double)newLongitud {
    CLLocation *location = [[CLLocation alloc]initWithLatitude:m_locationLatitude longitude:m_locationLongitude];
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:newLongitude longitude:newLongitud];
    return [location distanceFromLocation:newLocation]/1000;
}
@end
