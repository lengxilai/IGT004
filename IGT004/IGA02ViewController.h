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
#import "IGCoreDataUtil.h"
#import "Restaurant.h"
#import "IGFileUtil.h"
#import "IGUIButton.h"


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
}
- (id)initWithResult:(NSArray*)rs;
@end
