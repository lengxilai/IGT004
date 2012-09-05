//
//  IGA02TableViewCell.h
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGA02TableViewCell : UITableViewCell {
    //饭店标志图标
    NSString *iconName;
    //饭店名称
    UILabel *restaurantName;
    //饭店地址
    UILabel *restaurantAddress;
    //直线距离
    UILabel *distance;
    //人均消费
    UILabel *avgExpend;
}

@property (nonatomic, retain) UILabel *restaurantName;
@property (nonatomic, retain) UILabel *restaurantAddress;
@property (nonatomic, retain) UILabel *distance;
@property (nonatomic, retain) UILabel *avgExpend;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
