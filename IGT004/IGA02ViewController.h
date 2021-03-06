//
//  IGA02ViewController.h
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGA01ViewController.h"
#import "IGA02TableViewCell.h"
#import "IGA03ViewController.h"
#import "UIColor+IGColor.h"
#import "IGCommonDefine.h"
#import "Restaurant.h"
#import "IGFileUtil.h"
#import "IGUIButton.h"
#import "IGA04ViewController.h"


@interface IGA02ViewController : UIViewController<UITableViewDelegate,NSFetchedResultsControllerDelegate,UISearchBarDelegate,UITableViewDataSource> {
    
    //结果集管理器
    NSFetchedResultsController *fetchedResultsController;
    //背景view
    UIView *backgroundView;
    //数据列表显示view
    UITableView *dataListTableView;
    //搜说框
    UISearchBar *m_searchBar;
    NSArray *results;
    NSArray *tempResults;
}
- (id)initWithResult:(NSArray*)rs;

//点搜索按钮 
-(void)doSearch:(NSString *)searchText;
@end
