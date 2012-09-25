//
//  IGA05ViewController.m
//  IGT004
//
//  Created by wang chong on 12-9-12.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA05ViewController.h"

@interface IGA05ViewController ()

@end

@implementation IGA05ViewController

- (id)init
{
    
    self = [super init];
    return self;
}
-(id)initWithRestautant:(Restaurant *)res{
    self = [super init];
    //显示饭店
    m_geoArray = [[NSMutableArray alloc] init];
    IGGEOInfo *geoInfo = [[IGGEOInfo alloc] init];
    geoInfo.m_id = [[res id] doubleValue];
    geoInfo.m_name = [res address];
    
    //NSLog(@"Adding %@ to m_geoArray", geoInfo.m_name);
    
    geoInfo.m_description = [res name];
    
    CLLocationDegrees latitude = [[res latitude] doubleValue];
    CLLocationDegrees longitude = [[res longitude] doubleValue];
    
    CLLocationCoordinate2D coordinate2D = {latitude, longitude};
    geoInfo.m_coordinate2D = coordinate2D;
    geoInfo.res = res;
    restaurant = res;
   // NSLog(@"latitude:%@,longitude:%@",restaurant.latitude,restaurant.longitude);
    [m_geoArray addObject:geoInfo];

    return self;
}
-(void)loadView{
    self.navigationItem.title = @"舌尖上的大连";
    
    self.view = [[UIView alloc] initWithFrame: CGRectMake(0, 20, 320, 480)];
    m_mkMapView = [[MKMapView alloc] initWithFrame: CGRectMake(0, 0, 320, 460)];
    m_mkMapView.delegate = self;
    MKCoordinateRegion region = {{[restaurant.latitude doubleValue], [restaurant.longitude doubleValue]}, {0.01, 0.01}};
    m_mkMapView.region = region;
    [self.view addSubview: m_mkMapView];
    
    //导航条
    UIButton *rightButton = [IGUIButton getNavigationButton:@"navi_r_btn.png" title:(NSString*) @"路线" target:self selector:@selector(findAddress) frame:CGRectMake(A03BarButtonLeftX, A03BarButtonLeftY, A03BarButtonLeftW, A03BarButtonLeftH)];
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIButton *leftButton = [IGUIButton getNavigationButton:@"nav_l_btn.png" title:(NSString*)@"返回" target:self selector:@selector(goBack) frame:CGRectMake(A03BarButtonLeftX, A03BarButtonLeftY, A03BarButtonLeftW, A03BarButtonLeftH)];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //定位按钮
//    UIImageView *searchMyselfView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_iconH.png"]]; 
//    UIView *searchLocationView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 40, 40)];
//    searchLocationView.tag = A01SearchLocationTag;
//    [searchLocationView addSubview:searchMyselfView];
//    UITapGestureRecognizer *searchMyselfViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLocation)];
//    [searchLocationView addGestureRecognizer:searchMyselfViewTap];
//    [self.view addSubview:searchLocationView];
    
    // 页面读完了更新距离
    //[self showLocation];
    //[IGDistanceUpdate updateDistanceForResults:results];
}

- (void)viewDidLoad
{
    
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    //初始化所有餐厅信息
    for (IGGEOInfo *geoInfo in m_geoArray){
        IGBasicAnnotation *basicAnnotation = [[IGBasicAnnotation alloc] initWithGeoInfo:geoInfo];
        
        [m_mkMapView addAnnotation: basicAnnotation];
    }
    
    // 页面读完了更新距离
    //[self showLocation];
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
    //NSLog(@"%s %d, annotation = %@", __FUNCTION__, __LINE__, annotation);
    
    if ([annotation isKindOfClass: [MKUserLocation class]]) // showsUserLocation
    {
        return nil;
    }
    
    
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
	newAnnotation.pinColor = MKPinAnnotationColorGreen;
	newAnnotation.animatesDrop = YES; 
	newAnnotation.canShowCallout=YES;
    
    return newAnnotation;
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0){
    //吴嘉宾调用
    if ([[[view subviews] objectAtIndex:0] isKindOfClass:[MKAnnotationView class]]==NO) { 
        return;
    }
    IGMapAnnotationView *annotationMapView = (IGMapAnnotationView*)[[view subviews] objectAtIndex:0];
    if(annotationMapView){
        Restaurant *res = [annotationMapView restaurant];
        
        //NSLog(@"ddd");
        IGA03ViewController *a03ViewController = [[IGA03ViewController alloc] initByRestaurant:res];
        [self.navigationController pushViewController:a03ViewController animated:YES];
    }
}
// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //NSLog(@"%s %d, views = %@", __FUNCTION__, __LINE__, views);
    
}

// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //NSLog(@"%s %d, view = %@, control = %@", __FUNCTION__, __LINE__, view, control);
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    UIView *searchLocationView = [self.view viewWithTag:A01SearchLocationTag];
    UIImageView *searchMyselfView = [[searchLocationView subviews] objectAtIndex:0];
    [searchMyselfView setImage:[UIImage imageNamed:@"location_iconH.png"] ];
    
}
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
//    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
//    
//    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
//    [IGLocationUtil setUserLocation:[userLocation location]];
//    m_locationLatitude=[lat doubleValue];
//    m_locationLongitude=[lng doubleValue];
//    MKCoordinateSpan span;
//    
//    MKCoordinateRegion region;
//    
//    span.latitudeDelta=0.010;
//    
//    span.longitudeDelta=0.010;
//    
//    region.span=span;
//    
//    region.center=[userLocation coordinate];
//    
//    
//    [m_mkMapView setRegion:[m_mkMapView regionThatFits:region] animated:NO];
}

#pragma mark -
#pragma mark searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 400)];
    backgroundView.backgroundColor = [UIColor grayColor];
    backgroundView.alpha = 0.7;
    backgroundView.tag = 30001;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelInput)];
    [backgroundView addGestureRecognizer:singleTap];
    
    [self.view addSubview:backgroundView];
    return YES;
}
#pragma mark -3
#pragma mark 其他计算
-(double)getdistanceFromLocationWithLongitude:(double)newLongitude withLongitud:(double)newLongitud {
    CLLocation *location = [[CLLocation alloc]initWithLatitude:m_locationLatitude longitude:m_locationLongitude];
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:newLongitude longitude:newLongitud];
    return [location distanceFromLocation:newLocation]/1000;
}
-(void)showLocation{
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];//创建位置管理器
    locationManager.delegate=self;//设置代理
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    locationManager.distanceFilter=1000.0f;//设置距离筛选器
    [locationManager startUpdatingLocation];//启动位置管理器
    MKCoordinateSpan theSpan;
    //地图的范围 越小越精确
    theSpan.latitudeDelta=0.010;
    theSpan.longitudeDelta=0.010;
    MKCoordinateRegion theRegion;
    theRegion.center=[[locationManager location] coordinate];
    theRegion.span=theSpan;
    [m_mkMapView setRegion:theRegion];
    [IGLocationUtil setUserLocation:[locationManager location]];
    
    //[IGDistanceUpdate updateDistanceForResults:results];
    
    UIView *searchLocationView = [self.view viewWithTag:A01SearchLocationTag];
    UIImageView *searchMyselfView = [[searchLocationView subviews] objectAtIndex:0];
    [searchMyselfView setImage:[UIImage imageNamed:@"location_icon.png"] ];
}

-(void)findAddress{
    CLLocation *location = [IGLocationUtil getUserLocation];
    
    NSString *theString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%.4f,%.4f&daddr=%@,%@",location.coordinate.latitude,location.coordinate.longitude, restaurant.latitude, restaurant.longitude];

    theString =  [theString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

    NSURL *url = [[NSURL alloc] initWithString:theString];
    [[UIApplication sharedApplication] openURL:url];
}
// 点击返回按钮
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
