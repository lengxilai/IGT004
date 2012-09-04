//
//  IGA02ViewController.m
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA02ViewController.h"

@interface IGA02ViewController ()

@end

@implementation IGA02ViewController

- (id)init
{
    self = [super init];
    backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSLog(@"%@", NSStringFromCGRect([[UIScreen mainScreen] bounds]));
    backgroundView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:backgroundView];
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
