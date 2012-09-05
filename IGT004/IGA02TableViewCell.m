//
//  IGA02TableViewCell.m
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA02TableViewCell.h"
#import "UIColor+IGColor.h"
#import "IGCommonDefine.h"

@implementation IGA02TableViewCell

@synthesize restaurantName;
@synthesize restaurantAddress;
@synthesize distance;
@synthesize averageCost;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标志图片显示
        
        //饭店名称显示
        restaurantName = [[UILabel alloc] initWithFrame:CGRectMake(A02RestaurantNameX, A02RestaurantNameY, A02RestaurantNameW, A02RestaurantNameH)];
        restaurantName.adjustsFontSizeToFitWidth = YES;
        //饭店地址显示
        restaurantAddress = [[UILabel alloc] initWithFrame:CGRectMake(A02RestaurantAddressX, A02RestaurantAddressY, A02RestaurantAddressW, A02RestaurantAddressH)];
        restaurantAddress.adjustsFontSizeToFitWidth = YES;
        //直线距离显示
        distance = [[UILabel alloc] initWithFrame:CGRectMake(A02DistanceX, A02DistanceY, A02DistanceW, A02DistanceH)];
        distance.adjustsFontSizeToFitWidth = YES;
        //人均消费显示
        averageCost = [[UILabel alloc] initWithFrame:CGRectMake(A02AVGExpandX, A02AVGExpandY, A02AVGExpandW, A02AVGExpandH)];
        averageCost.adjustsFontSizeToFitWidth = YES;
        
        
        //测试用
        restaurantName.backgroundColor = [UIColor clearColor];
        restaurantAddress.backgroundColor = [UIColor clearColor];
        distance.backgroundColor = [UIColor clearColor];
        averageCost.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:restaurantName];
        [self.contentView addSubview:restaurantAddress];
        [self.contentView addSubview:distance];
        [self.contentView addSubview:averageCost];
        self.contentView.backgroundColor = [UIColor bottomLineBackgroundImageColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
