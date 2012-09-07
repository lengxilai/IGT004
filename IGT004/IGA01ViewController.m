//
//  IGA01ViewControllerViewController.m
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA01ViewController.h"
#import "IGDistanceUpdate.h"
@interface IGA01ViewController ()

@end

@implementation IGA01ViewController
#pragma mark -
#pragma mark Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self getRestaurantList];
        //初始化所有餐厅信息
        for (IGGEOInfo *geoInfo in m_geoArray){
            IGBasicAnnotation *basicAnnotation = [[IGBasicAnnotation alloc] initWithGeoInfo:geoInfo];
            
            [m_mkMapView addAnnotation: basicAnnotation];
        }

    }
    return self;
}
-(id)initWithRestautant:(Restaurant *)res{
    self.view = [[UIView alloc] initWithFrame: CGRectMake(0, 20, 320, 480)];
    
    
    //初始化饭店位置
    MKCoordinateRegion region = {{[[res latitude ] doubleValue], [[res longitude]doubleValue]}, {0.016, 0.016}};
    m_mkMapView.region = region;
    //显示饭店
    IGGEOInfo *geoInfo = [[IGGEOInfo alloc] init];
    geoInfo.m_id = [[res id] doubleValue];
    geoInfo.m_name = [res name];
    
    NSLog(@"Adding %@ to m_geoArray", geoInfo.m_name);
    
    geoInfo.m_description = [res abbrName];
    
    CLLocationDegrees latitude = [[res latitude] doubleValue];
    CLLocationDegrees longitude = [[res longitude] doubleValue];
    
    CLLocationCoordinate2D coordinate2D = {latitude, longitude};
    geoInfo.m_coordinate2D = coordinate2D;
    geoInfo.res = res;

    return self;
}
-(void)loadView{
    
    self.navigationItem.title = @"舌尖上的大连";
    
    self.view = [[UIView alloc] initWithFrame: CGRectMake(0, 20, 320, 480)];
    m_mkMapView = [[MKMapView alloc] initWithFrame: CGRectMake(0, 0, 320, 460)];
    m_mkMapView.delegate = self;
    m_mkMapView.showsUserLocation=YES;
    [self.view addSubview: m_mkMapView];
    //搜索框
    m_searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];  ;
    m_searchBar.delegate = self;
    m_searchBar.barStyle = UIBarStyleBlackTranslucent;
    m_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    UIImageView *backSearchBarimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBar_bg.png"]];
    backSearchBarimageView.alpha = 0.7;
    [m_searchBar insertSubview:backSearchBarimageView atIndex:1];
    [[m_searchBar.subviews objectAtIndex:0]removeFromSuperview]; 
    m_searchBar.placeholder = @"赶紧找找大连街最好歹的！";  
    [self.view addSubview:m_searchBar];
    
    //定位按钮
    UIImageView *searchMyselfView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_icon.png"]]; 
    UIView *searchLocationView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 40, 40)];
    [searchLocationView addSubview:searchMyselfView];
    UITapGestureRecognizer *searchMyselfViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLocation)];
    [searchLocationView addGestureRecognizer:searchMyselfViewTap];
    [self.view addSubview:searchLocationView];
}

- (void)viewDidLoad
{
    
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
    
//    IGBasicAnnotation *basicAnnotation = (IGBasicAnnotation *)annotation;
    MKAnnotationView *mkAnnotationView;
    IGMapAnnotationView *annotationMapView = [[IGMapAnnotationView alloc] initWithAnnotation:annotation];
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"annotationView"];
    annotationView.userInteractionEnabled = YES;
    annotationView.alpha = 0.9;
    annotationView.canShowCallout = NO;
    //annotationView.image = [UIImage imageNamed:@"logo.jpg"];
    //    [annotationView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.jpg"]]];
    
    [annotationView addSubview:annotationMapView];
    mkAnnotationView = annotationView;
    
    
//    UIButton *addButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
//    addButton.tag = basicAnnotation.m_geoInfo.m_id;
//    [addButton addTarget:self action:@selector(showCompanyDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    return mkAnnotationView;
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0){
    //吴嘉宾调用
    IGMapAnnotationView *annotationMapView = (IGMapAnnotationView*)[[view subviews] objectAtIndex:0];
    Restaurant *res = [annotationMapView restaurant];
    
    NSString *namee=@"中国,陕西,西安,高新区,唐兴路";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",[namee stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
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
    [IGLocationUtil setUserLocation:[userLocation location]];
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
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nil];
    NSArray *results = [IGCoreDataUtil queryForArray:@"Restaurant" queryCondition:nil sortDescriptors:sortDescriptors];
    
    for (Restaurant *r in results) {
        IGGEOInfo *geoInfo = [[IGGEOInfo alloc] init];
        
        geoInfo.m_id = [[r id] doubleValue];
        geoInfo.m_name = [r name];
        
        NSLog(@"Adding %@ to m_geoArray", geoInfo.m_name);
        
        geoInfo.m_description = [r abbrName];
        
        CLLocationDegrees latitude = [[r latitude] doubleValue];
        CLLocationDegrees longitude = [[r longitude] doubleValue];
        
        CLLocationCoordinate2D coordinate2D = {latitude, longitude};
        geoInfo.m_coordinate2D = coordinate2D;
        geoInfo.res = r;
        [m_geoArray addObject: geoInfo];
    }
    
}
#pragma mark -
#pragma mark searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 400)];
    backgroundView.backgroundColor = [UIColor grayColor];
    backgroundView.alpha = 0.7;
    backgroundView.tag = 10001;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelInput)];
    [backgroundView addGestureRecognizer:singleTap];

    [self.view addSubview:backgroundView];
    return YES;
}
//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchText = [searchBar text];
    //吴嘉宾调用
}
#pragma mark -3
#pragma mark 其他计算
-(double)getdistanceFromLocationWithLongitude:(double)newLongitude withLongitud:(double)newLongitud {
    CLLocation *location = [[CLLocation alloc]initWithLatitude:m_locationLatitude longitude:m_locationLongitude];
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:newLongitude longitude:newLongitud];
    return [location distanceFromLocation:newLocation]/1000;
}
//取消搜索
-(void)cancelInput{
    [[self.view viewWithTag:10001] removeFromSuperview];
    [m_searchBar resignFirstResponder];
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
    
    [IGDistanceUpdate updateDistance];
}
@end
