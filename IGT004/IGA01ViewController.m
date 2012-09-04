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
    
    MKCoordinateRegion region = {{39.976002, 116.317577}, {0.016, 0.016}};
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
    //annotationView.image = [UIImage imageNamed: basicAnnotation.m_geoInfo.m_imageName];
    annotationView.alpha = 0.9;
    annotationView.canShowCallout = TRUE;
    [annotationView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed: basicAnnotation.m_geoInfo.m_imageName]]];
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

@end
