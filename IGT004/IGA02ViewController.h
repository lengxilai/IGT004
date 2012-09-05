//
//  IGA02ViewController.h
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IGA02TableViewCell.h"

@interface IGA02ViewController : UIViewController<UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextFieldDelegate,UITableViewDataSource> {
    
    //结果集管理器
    NSFetchedResultsController *fetchedResultsController;
    //背景view
    UIView *backgroundView;
    //数据列表显示view
    UITableView *dataListTableView;
    //数据列表显示cell
    IGA02TableViewCell *a02TableViewCell;
}

@end
