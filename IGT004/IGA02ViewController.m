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

#pragma mark -
#pragma mark 初始化方法
- (id)initWithResult:(NSArray*)rs
{
    self = [super init];
    self.title = @"舌尖上的大连";
    //取得屏幕尺寸
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    //设置背景为设备屏幕大小
    backgroundView = [[UIView alloc] initWithFrame:screenSize];
    //设置背景颜色为efefef
    backgroundView.backgroundColor = [UIColor colorWithHex:0xefefef alpha:1.0];
    //把背景view放入到self
    [self.view addSubview:backgroundView];
    
    //搜索框
    m_searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];  ;
    m_searchBar.delegate = self;
    m_searchBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackTranslucent;
    m_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    UIImageView *backSearchBarimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBar_bg.png"]];
    backSearchBarimageView.alpha = 0.7;
    [m_searchBar insertSubview:backSearchBarimageView atIndex:1];
    [[m_searchBar.subviews objectAtIndex:0]removeFromSuperview]; 
    m_searchBar.placeholder = @"赶紧找找大连街最好歹的！";  
    [self.view addSubview:m_searchBar];
    

    //内容设置
    dataListTableView = [[UITableView alloc] initWithFrame:CGRectMake(A02TableViewX, A02TableViewY, screenSize.size.width, screenSize.size.height+441) style:UITableViewStylePlain];
    
    dataListTableView.rowHeight = A02CellHight;
    dataListTableView.backgroundColor = [UIColor clearColor];
    
    [dataListTableView setDelegate:self];
    [dataListTableView setDataSource:self];
    dataListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设定数据
    results = rs;
    tempResults = rs;
    [self.view addSubview:dataListTableView];
    
    //导航左按钮
    UIButton *leftButton = [IGUIButton getNavigationButton:@"nav_l_btn.png" title:@"地图" target:self selector:@selector(goToA01) frame:CGRectMake(A03BarButtonLeftX, A03BarButtonLeftY, A03BarButtonLeftW, A03BarButtonLeftH)];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //导航右按钮
    UIButton *rightButton = [IGUIButton getNavigationButton:@"info.png" title:@"" target:self selector:@selector(goToA04) frame:CGRectMake(A03BarButtonRightX, A03BarButtonRightY, 34, 33)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
        cell = [[IGA02TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHex:0x990000 alpha:1.0];

    Restaurant *restaurant = (Restaurant *)[results objectAtIndex:indexPath.row];
    
    [self updateContentToCell:cell :restaurant];
    
    
    return cell;
}

//点cell进入详细画面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Restaurant *restaurant = (Restaurant *)[results objectAtIndex:indexPath.row];
    IGA03ViewController *a03ViewController = [[IGA03ViewController alloc] initByRestaurant:restaurant];
    [self.navigationController pushViewController:a03ViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
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

#pragma mark -
#pragma mark searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 400)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.7;
    bgView.tag = 10001;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelInput)];
    [bgView addGestureRecognizer:singleTap];
    
    [self.view addSubview:bgView];
    return YES;
}

//取消搜索
-(void)cancelInput{
    results = tempResults;
    [[self.view viewWithTag:10001] removeFromSuperview];
    [m_searchBar resignFirstResponder];
    [dataListTableView reloadData];
}

/*键盘搜索按钮*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [[self.view viewWithTag:10001] removeFromSuperview];
    [m_searchBar resignFirstResponder];
    NSString *inputStr = [searchBar text];
	[self doSearch:inputStr];
}

/*
 *点搜索按钮 
 */  
-(void)doSearch:(NSString *)searchText{  
    //搜索关键字
    NSString *key = [NSString stringWithFormat:@"%@",searchText];
    //搜索结果集
    NSMutableArray *rsOfSearch = [NSMutableArray array];
    for (Restaurant *restaurant in tempResults) {
        //饭店名
        NSString *name = restaurant.name;
        //地址
        NSString *address = restaurant.address;
        //简介
        NSString *memo = restaurant.descriptionMemo;
        NSRange nameRange = [name rangeOfString:key];
        NSRange addressRange = [address rangeOfString:key];
        NSRange memoRange = [memo rangeOfString:key];
        //在饭店名、地址、简介中存在关键字就放入到结果集中
        if (nameRange.length != 0 || addressRange.length != 0 || memoRange.length != 0) {
            [rsOfSearch addObject:restaurant]; 
        }
    }
    //如果结果集为空就全显示
    if ([rsOfSearch count] != 0) {
        results = rsOfSearch;
    } else {
        results = tempResults;
    }

    //重新加载(刷新)。  
    [dataListTableView reloadData];  
}  

#pragma mark -
#pragma mark datasource做成

// 向cell中的填充内容
-(void)updateContentToCell:(IGA02TableViewCell*) cell :(Restaurant *) newRestaurant{

    UIImage *img = [[UIImage alloc] initWithContentsOfFile: [IGFileUtil getIconImageByRestaurantId:[self toString:newRestaurant.id] forIconName:newRestaurant.iconName]];
    [cell.iconImageView setImage:img];
    cell.restaurantName.text = newRestaurant.name;
    cell.restaurantAddress.text = newRestaurant.address;
    cell.distance.text = [NSString stringWithFormat:@"%@%@",@"距离：", [self getDistance:newRestaurant.distance]];
    cell.averageCost.text = [NSString stringWithFormat:@"人均消费：%d元", newRestaurant.averageCost.intValue];
    
}

//距离换算 
-(NSString *) getDistance:(NSNumber *) distance {
    float newDistance;
    NSString *distanceStr;
    if (distance.intValue > 1000) {
        newDistance = distance.floatValue / 1000;
        distanceStr = [NSString stringWithFormat:@"%.1f%@", newDistance, @"公里"];
    } else {
        newDistance = distance.floatValue;
        distanceStr = [NSString stringWithFormat:@"%.f%@", newDistance, @"米"];
    }
    return distanceStr;
}

#pragma mark -
#pragma mark 其它工具方法
// 取得饭店个数个数
- (NSInteger) getRow {
    return [results count];
}

//NSNumbe to NSString
-(NSString *) toString:(NSNumber *) number {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter stringFromNumber:number];
}

//去地图页面
-(void)goToA01 {
    [self.navigationController popViewControllerAnimated:YES];
}
//去a04地图页面
-(void)goToA04 {
    [self cancelInput];
    IGA04ViewController *a04ViewController = [[IGA04ViewController alloc] init];
    [self.navigationController pushViewController:a04ViewController animated:YES];

}
@end
