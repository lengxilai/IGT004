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
#import "IGCoreDataUtil.h"
#import "Restaurant.h"

@interface IGA02ViewController ()

@end

@implementation IGA02ViewController

- (id)init
{
    self = [super init];
    
    //取得屏幕尺寸
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    NSLog(@"%f", screenSize.size.width);
    //设置背景为设备屏幕大小
    backgroundView = [[UIView alloc] initWithFrame:screenSize];
    //设置背景颜色为efefef
    backgroundView.backgroundColor = [UIColor colorWithHex:0xefefef alpha:1.0];
    //把背景view放入到self
    [self.view addSubview:backgroundView];

    //
    dataListTableView = [[UITableView alloc] initWithFrame:CGRectMake(A02TableViewX, A02TableViewY, screenSize.size.width, screenSize.size.height) style:UITableViewStylePlain];
    
    dataListTableView.rowHeight = A02CellHight;
    dataListTableView.backgroundColor = [UIColor clearColor];
    
    [dataListTableView setDelegate:self];
    [dataListTableView setDataSource:self];
    dataListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self fetchedResultsController];

    [self.view addSubview:dataListTableView];
    
    return self;
}


// 取得section数目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 取得待显示行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getRow];
}

// cell中要显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    IGA02TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[IGA02TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    Restaurant *restaurant = (Restaurant *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    [self updateContentToCell:cell :restaurant];
    
    
    return cell;
}


- (void)viewDidLoad
{
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

// 生成列表的datasourse
- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return self.fetchedResultsController;
    }
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nil];
    NSFetchedResultsController *newFetchedResultsController = 
    [IGCoreDataUtil queryForFetchedResult:@"Restaurant" queryCondition:nil sortDescriptors:sortDescriptors];
    newFetchedResultsController.delegate = self;
    fetchedResultsController = newFetchedResultsController;
    
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    return fetchedResultsController;
}

// 取得饭店个数个数
- (NSInteger) getRow {
    NSInteger row = 0;
    if ([[fetchedResultsController sections] count] > 0) {
        row = [[[fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    }
    return row;
}

// 向cell中的填充内容
-(void)updateContentToCell:(IGA02TableViewCell*) cell :(Restaurant *) newRestaurant{
    
    cell.restaurantName.text = newRestaurant.name;
    cell.restaurantAddress.text = newRestaurant.address;
    cell.distance.text = @"距离：2.3km";
    cell.averageCost.text = [NSString stringWithFormat:@"人均消费：%d元", newRestaurant.averageCost.intValue];
    
}


@end
