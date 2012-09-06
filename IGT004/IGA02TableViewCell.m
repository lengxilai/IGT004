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
#import "UIColor+IGColor.h"

@implementation IGA02TableViewCell

@synthesize iconImageView;
@synthesize restaurantName;
@synthesize restaurantAddress;
@synthesize distance;
@synthesize averageCost;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标志图片显示
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(A02IconImageViewX, A02IconImageViewY, A02IconImageViewW, A02IconImageViewH)];
        //饭店名称显示
        restaurantName = [[UILabel alloc] initWithFrame:CGRectMake(A02RestaurantNameX, A02RestaurantNameY, A02RestaurantNameW, A02RestaurantNameH)];
        restaurantName.adjustsFontSizeToFitWidth = YES;
        restaurantName.textColor = [UIColor colorWithHex:0x000000 alpha:1.0];
        //饭店地址显示
        restaurantAddress = [[UILabel alloc] initWithFrame:CGRectMake(A02RestaurantAddressX, A02RestaurantAddressY, A02RestaurantAddressW, A02RestaurantAddressH)];
        restaurantAddress.adjustsFontSizeToFitWidth = YES;
        restaurantAddress.textColor = [UIColor colorWithHex:0x666666 alpha:1.0];
        //直线距离显示
        distance = [[UILabel alloc] initWithFrame:CGRectMake(A02DistanceX, A02DistanceY, A02DistanceW, A02DistanceH)];
        distance.adjustsFontSizeToFitWidth = YES;
        distance.textColor = [UIColor colorWithHex:0x666666 alpha:1.0];
        //人均消费显示
        averageCost = [[UILabel alloc] initWithFrame:CGRectMake(A02AVGExpandX, A02AVGExpandY, A02AVGExpandW, A02AVGExpandH)];
        averageCost.adjustsFontSizeToFitWidth = YES;
        averageCost.textColor = [UIColor colorWithHex:0x990000 alpha:1.0];
        
        
        //测试用
        restaurantName.backgroundColor = [UIColor clearColor];
        restaurantAddress.backgroundColor = [UIColor clearColor];
        distance.backgroundColor = [UIColor clearColor];
        averageCost.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:iconImageView];
        [self.contentView addSubview:restaurantName];
        [self.contentView addSubview:restaurantAddress];
        [self.contentView addSubview:distance];
        [self.contentView addSubview:averageCost];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(A02BottomLineX, A02BottomLineY, A02BottomLineW, A02BottomLineH)];
        bottomView.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [self.contentView addSubview:bottomView];
        //self.contentView.backgroundColor = [UIColor bottomLineBackgroundImageColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
