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
#import "IGFileUtil.h"

@interface IGA02ViewController ()

@end

@implementation IGA02ViewController

@synthesize a03ViewController;

#pragma mark -
#pragma mark 初始化方法
- (id)init
{
    self = [super init];
    
    //取得屏幕尺寸
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    //设置背景为设备屏幕大小
    backgroundView = [[UIView alloc] initWithFrame:screenSize];
    //设置背景颜色为efefef
    backgroundView.backgroundColor = [UIColor colorWithHex:0xefefef alpha:1.0];
    //把背景view放入到self
    [self.view addSubview:backgroundView];

    //内容设置
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

#pragma mark -
#pragma mark tableview代理方法
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

//点cell进入详细画面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Restaurant *restaurant = (Restaurant *)[fetchedResultsController objectAtIndexPath:indexPath];
    self.a03ViewController = [[IGA03ViewController alloc] initByRestaurant:restaurant];
    [self.navigationController pushViewController:self.a03ViewController animated:YES];
}

#pragma mark -
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

#pragma mark -
#pragma mark datasource做成

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

// 向cell中的填充内容
-(void)updateContentToCell:(IGA02TableViewCell*) cell :(Restaurant *) newRestaurant{

    UIImage *img = [[UIImage alloc] initWithContentsOfFile: [IGFileUtil getIconImageByRestaurantId:[self toString:newRestaurant.id] forIconName:newRestaurant.iconName]];
    [cell.iconImageView setImage:img];
    cell.restaurantName.text = newRestaurant.name;
    cell.restaurantAddress.text = newRestaurant.address;
    cell.distance.text = [NSString stringWithFormat:@"%@%@",@"距离: ", [self toString:newRestaurant.distance]];
    cell.averageCost.text = [NSString stringWithFormat:@"人均消费：%d元", newRestaurant.averageCost.intValue];
    
}

#pragma mark -
#pragma mark 其它工具方法
// 取得饭店个数个数
- (NSInteger) getRow {
    NSInteger row = 0;
    if ([[fetchedResultsController sections] count] > 0) {
        row = [[[fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
    }
    return row;
}

//NSNumbe to NSString
-(NSString *) toString:(NSNumber *) number {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter stringFromNumber:number];
}


@end
