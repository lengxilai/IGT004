//
//  IGA01ViewControllerViewController.m
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA01ViewController.h"
#import "IGDistanceUpdate.h"
#import <SystemConfiguration/SystemConfiguration.h>
@interface IGA01ViewController ()

@end

@implementation IGA01ViewController
#pragma mark -
#pragma mark Initialization
- (id)init
{
    
    self = [super init];
    if (self) {
    }
    return self;
}
-(id)initWithRestautant:(Restaurant *)res{
    self = [super init];
    //self.view = [[UIView alloc] initWithFrame: CGRectMake(0, 20, 320, 480)];
    
    
    //初始化饭店位置
//    MKCoordinateRegion region = {{[[res latitude ] doubleValue], [[res longitude]doubleValue]}, {0.016, 0.016}};
//    m_mkMapView.region = region;
    //显示饭店
    m_geoArray = [[NSMutableArray alloc] init];
    IGGEOInfo *geoInfo = [[IGGEOInfo alloc] init];
    geoInfo.m_id = [[res id] doubleValue];
    geoInfo.m_name = [res name];
    
    //NSLog(@"Adding %@ to m_geoArray", geoInfo.m_name);
    
    geoInfo.m_description = [res abbrName];
    
    CLLocationDegrees latitude = [[res latitude] doubleValue];
    CLLocationDegrees longitude = [[res longitude] doubleValue];
    
    CLLocationCoordinate2D coordinate2D = {latitude, longitude};
    geoInfo.m_coordinate2D = coordinate2D;
    geoInfo.res = res;
    
    [m_geoArray addObject:geoInfo];
       
    float zoomLevel = 0.02;  
    MKCoordinateRegion region2 = MKCoordinateRegionMake(coordinate2D, MKCoordinateSpanMake(zoomLevel, zoomLevel));  
    [m_mkMapView setRegion:[m_mkMapView regionThatFits:region2] animated:YES];  
    return self;
}
-(void)loadView{
    [self getRestaurantList];
    self.navigationItem.title = @"舌尖上的大连";http://www.cairot.com/
    
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
    
    //导航条
    UIButton *rightButton = [IGUIButton getNavigationButton:@"navi_r_btn.png" title:(NSString*) @"列表" target:self selector:@selector(goToA02) frame:CGRectMake(A03BarButtonLeftX, A03BarButtonLeftY, A03BarButtonLeftW, A03BarButtonLeftH)];
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationController.navigationBar.backItem.hidesBackButton = YES;
    //定位按钮
    UIImageView *searchMyselfView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_icon.png"]]; 
    UIView *searchLocationView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 40, 40)];
    searchLocationView.tag = A01SearchLocationTag;
    [searchLocationView addSubview:searchMyselfView];
    UITapGestureRecognizer *searchMyselfViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLocation)];
    [searchLocationView addGestureRecognizer:searchMyselfViewTap];
    [self.view addSubview:searchLocationView];
    
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
    
    //    IGBasicAnnotation *basicAnnotation = (IGBasicAnnotation *)annotation;
    MKAnnotationView *mkAnnotationView;
    IGMapAnnotationView *annotationMapView = [[IGMapAnnotationView alloc] initWithAnnotation:annotation];
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"annotationView"];
    annotationView.userInteractionEnabled = YES;
    annotationView.alpha = 0.9;
    annotationView.image = [UIImage imageNamed:@"hotel_full_annotation_shadow.png"];
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
    if ([[[view subviews] objectAtIndex:0] isKindOfClass:[IGMapAnnotationView class]]==NO) { 
        //NSLog(@"%@",[[[view subviews] objectAtIndex:0] class]);
        return;
    }
    IGMapAnnotationView *annotationMapView = (IGMapAnnotationView*)[[view subviews] objectAtIndex:0];
    if(annotationMapView){
        Restaurant *res = [annotationMapView restaurant];

        //NSLog(@"ddd");
        IGA03ViewController *a03ViewController = [[IGA03ViewController alloc] initByRestaurant:res];
        [self.navigationController pushViewController:a03ViewController animated:YES];
    }
    [mapView deselectAnnotation:[view annotation] animated:YES];
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
    
    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
    
    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
    MKUserLocation *userLocationOld = [IGLocationUtil getUserLocation];
    [IGLocationUtil setUserLocation:[userLocation location]];
    m_locationLatitude=[lat doubleValue];
    m_locationLongitude=[lng doubleValue];
    MKCoordinateSpan span;
    
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.020;
    
    span.longitudeDelta=0.020;
    
    region.span=span;
    
    region.center=[userLocation coordinate];
    
    if(!userLocationOld)
        //[m_mkMapView setRegion:[m_mkMapView regionThatFits:region] animated:NO];
        [self showLocation];
}

#pragma mark -
#pragma mark data
-(void)getRestaurantList{
    m_geoArray = [[NSMutableArray alloc] init];
    
    //    id<PLResultSet> result;
    //	result = [g_plDatabase executeQuery: @"Select ID, Name, Description, ImageName, Latitude, Longitude from GeoInfo"];
    //	
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sd,nil];
    results = [IGCoreDataUtil queryForArray:@"Restaurant" queryCondition:nil sortDescriptors:sortDescriptors];
    
    for (Restaurant *r in results) {
        IGGEOInfo *geoInfo = [[IGGEOInfo alloc] init];
        
        geoInfo.m_id = [[r id] doubleValue];
        geoInfo.m_name = [r name];
        
        //NSLog(@"Adding %@ to m_geoArray", geoInfo.m_name);
        
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
    backgroundView.tag = A01BackgroundViewTag;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelInput)];
    [backgroundView addGestureRecognizer:singleTap];
    
    [self.view addSubview:backgroundView];
    return YES;
}
//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [[self.view viewWithTag:20001] removeFromSuperview];
    [m_searchBar resignFirstResponder];
    NSString *inputStr = [searchBar text];
    IGA02ViewController *a02ViewController = [[IGA02ViewController alloc] initWithResult:results];
	[a02ViewController doSearch:inputStr];
    m_searchBar.text = @"";
    [self.navigationController pushViewController:a02ViewController animated:YES];
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
    [[self.view viewWithTag:20001] removeFromSuperview];
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
    theSpan.latitudeDelta=0.020;
    theSpan.longitudeDelta=0.020;
    MKCoordinateRegion theRegion;
    theRegion.center=[[locationManager location] coordinate];
    theRegion.span=theSpan;
    [m_mkMapView setRegion:theRegion];
    [IGLocationUtil setUserLocation:[locationManager location]];
    
    [IGDistanceUpdate updateDistanceForResults:results];
    
    UIView *searchLocationView = [self.view viewWithTag:A01SearchLocationTag];
    UIImageView *searchMyselfView = [[searchLocationView subviews] objectAtIndex:0];
    [searchMyselfView setImage:[UIImage imageNamed:@"location_icon.png"] ];
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:[locationManager location] completionHandler:^(NSArray *placemarks,NSError *error)
     {
         for(CLPlacemark *placemark in placemarks)
         {
             [self showAlertWithPlacemark:placemark];
         }
     }];
    
}
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation {
    //获取所在地城市名
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error)
     {
         for(CLPlacemark *placemark in placemarks)
         {
             NSString *currentCity=[[placemark.addressDictionary objectForKey:@"City"] substringToIndex:2];
            // NSLog(@"str%@",currentCity);
         }
     }];
}
//去列表页面
-(void)goToA02 {
    [self cancelInput];
    IGA02ViewController *a02ViewController = [[IGA02ViewController alloc] initWithResult:results];
    [self.navigationController pushViewController:a02ViewController animated:YES];
}
-(void)showAlertWithPlacemark:(CLPlacemark *)placemark{
    NSString *currentCity=[[placemark.addressDictionary objectForKey:@"City"] substringToIndex:2];
    if(![currentCity isEqual:@"Da" ] && ![currentCity isEqual:@"大连"] && ![currentCity isEqual:@"大連"]){
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"亲！你好像不在大连啊！要不你用列表来看吧？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil ];
        [av show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self goToA02];
    }
}
@end
