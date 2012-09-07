//
//  IGA03ViewController.h
//  IGT004
//
//  Created by wu jiabin on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "UIColor+IGColor.h"
#import "IGCommonDefine.h"
#import "IGFileUtil.h"
#import "IGUIButton.h"

@interface IGA03ViewController : UIViewController<UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextFieldDelegate,UITableViewDataSource> {
    //背景view
    UIView *backgroundView;
    
    //上半部分UIView
    UIView *topUIView;
    //标志图片
    UIImageView *iconImageView;
    //饭店名称
    UILabel *restaurantNameLabel;
    //距离
    UILabel *distanceLabel;
    //人均消费
    UILabel *averageCostLabel;
    //横线1
    UIView *line1View;
    
    //下半部分UIView
    UIView *bottomView;
    //地址
    UILabel *addressLabel;
    //电话
    UILabel *telLabel;
    //简介
    UILabel *memoLabel;
    //横线2
    UIView *line2View;
    //横线3
    UIView *line3View;    
    
}


- (id)initByRestaurant:(Restaurant *) restaurant;
// 点击返回按钮
- (void)goBack;
//NSNumbe to NSString
-(NSString *) toString:(NSNumber *) number;
@end
