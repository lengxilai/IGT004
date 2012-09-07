//
//  IGUINavigationController.m
//  IGT004
//
//  Created by wu jiabin on 12-9-7.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGUINavigationController.h"
#import "UIColor+IGColor.h"

@implementation IGUINavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
        self.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self.navigationBar setBackgroundColor:[UIColor clearColor]];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bag.png"] forBarMetrics:UIBarMetricsDefault];
//        self.view.backgroundColor = [UIColor navigationBarImageColor];
        
        // 广告页追加 收费版去除广告
        //[self.view addSubview:[IGAdBannerViewController shareIadView]];
    }
    return self;
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

@end
