//
//  IGA02ViewController.m
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA02ViewController.h"
#import "UIColor+IGColor.h"
#import "IGCommonDefine.h"

@interface IGA02ViewController ()

@end

@implementation IGA02ViewController

- (id)init
{
    self = [super init];
    //设置背景为设备屏幕大小
    backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置背景颜色为efefef
    backgroundView.backgroundColor = [UIColor colorWithHex:0xefefef alpha:1.0];
    //把背景view放入到self
    [self.view addSubview:backgroundView];
    
    //
    dataListTableView = [[UITableView alloc] initWithFrame:CGRectMake(A02TableViewX, A02TableViewY, A02TableViewW, A02TableViewH) style:UITableViewStylePlain];
    
    UIImageView *cellBackgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_line.png"]];
    dataListTableView.rowHeight = A02CellHight;
    dataListTableView.backgroundColor = [UIColor clearColor];
    [dataListTableView addSubview:cellBackgroundImg];
//    dataListTableView.backgroundColor = [UIColor bottomLineBackgroundImageColor];
//    dataListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:dataListTableView];
    
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
