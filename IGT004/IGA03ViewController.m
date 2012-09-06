//
//  IGA03ViewController.m
//  IGT004
//
//  Created by wu jiabin on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA03ViewController.h"
#import "UIColor+IGColor.h"
#import "IGCommonDefine.h"
#import "IGFileUtil.h"

@interface IGA03ViewController ()

@end

@implementation IGA03ViewController

- (id)initByRestaurant:(Restaurant *) restaurant
{
    self = [super init];
    if (self) {
        //取得屏幕尺寸
        CGRect screenSize = [[UIScreen mainScreen] bounds];
        //设置背景为设备屏幕大小
        backgroundView = [[UIView alloc] initWithFrame:screenSize];
        //设置背景颜色为efefef
        backgroundView.backgroundColor = [UIColor colorWithHex:0xefefef alpha:1.0];
        //把背景view放入到self
        [self.view addSubview:backgroundView];
        
        //上半部分显示内容
        topUIView = [[UIView alloc] initWithFrame:CGRectMake(A03TopViewX, A03TopViewY, A03TopViewW, A03TopViewH)];
//        topUIView.backgroundColor = [UIColor grayColor];
        //标志图片
        UIImage *iconImg = [[UIImage alloc] initWithContentsOfFile: [IGFileUtil getIconImageByRestaurantId:[self toString:restaurant.id] forIconName:restaurant.iconName]];
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(A03IconImageViewX, A03IconImageViewY, A03IconImageViewW, A03IconImageViewH)];
        [iconImageView setImage:iconImg];
        [topUIView addSubview:iconImageView];
        //饭店名称
        restaurantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03RestaurantNameX, A03RestaurantNameY, A03RestaurantNameW, A03RestaurantNameH)];
        restaurantNameLabel.backgroundColor = [UIColor clearColor];
        restaurantNameLabel.adjustsFontSizeToFitWidth = YES;
        restaurantNameLabel.textColor = [UIColor colorWithHex:0x000000 alpha:1.0];
        restaurantNameLabel.text = restaurant.name;
        [topUIView addSubview:restaurantNameLabel];
        //距离
        distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03DistanceX, A03DistanceY, A03DistanceW, A03DistanceH)];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.adjustsFontSizeToFitWidth = YES;
        distanceLabel.textColor = [UIColor colorWithHex:0x666666 alpha:1.0];
        distanceLabel.text = [NSString stringWithFormat:@"%@%@", @"距离: ", [self toString:restaurant.distance]];
        [topUIView addSubview:distanceLabel];
        //人均消费
        averageCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03AVGExpandX, A03AVGExpandY, A03AVGExpandW, A03AVGExpandH)];
        averageCostLabel.backgroundColor = [UIColor clearColor];
        averageCostLabel.adjustsFontSizeToFitWidth = YES;
        averageCostLabel.textColor = [UIColor colorWithHex:0x990000 alpha:1.0];
        averageCostLabel.text = [NSString stringWithFormat:@"%@%@", @"人均消费:", restaurant.averageCost];
        [topUIView addSubview:averageCostLabel];
        //中间横线1
        line1View = [[UIView alloc] initWithFrame:CGRectMake(A03BottomLine1X, A03BottomLine1Y, A03BottomLine1W, A03BottomLine1H)];
        line1View.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [topUIView addSubview:line1View];
        
        [self.view addSubview:topUIView];
        
        
        
        //下半部分显示内容
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(A03BottomTableViewX, A03BottomTableViewY, A03BottomTableViewW, A03BottomTableViewH)];
        //地址
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03AddressX, A03AddressY, A03AddressW, A03AddressH)];
        addressLabel.text = [NSString stringWithFormat:@"%@%@", @"地址:", restaurant.address];
        addressLabel.adjustsFontSizeToFitWidth = YES;
        addressLabel.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:addressLabel];
        
        //中间横线2
        line2View = [[UIView alloc] initWithFrame:CGRectMake(A03BottomLine2X, A03BottomLine2Y, A03BottomLine2W, A03BottomLine2H)];
        line2View.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [bottomView addSubview:line2View];
        
        //电话
        telLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03TelX, A03TelY, A03TelW, A03TelH)];
        telLabel.text = [NSString stringWithFormat:@"%@%@", @"电话:", restaurant.tel];
        telLabel.adjustsFontSizeToFitWidth = YES;
        telLabel.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:telLabel];
        
        //中间横线3
        line3View = [[UIView alloc] initWithFrame:CGRectMake(A03BottomLine3X, A03BottomLine3Y, A03BottomLine3W, A03BottomLine3H)];
        line3View.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [bottomView addSubview:line3View];
        
        //简介
        memoLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03MemoX, A03MemoY, A03MemoW, A03MemoH)];
        memoLabel.text = [NSString stringWithFormat:@"%@%@", @"简介:", restaurant.descriptionMemo];
        memoLabel.numberOfLines = 0;
        [memoLabel sizeToFit];
        memoLabel.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:memoLabel];
        
//        bottomView.backgroundColor = [UIColor redColor];
        [self.view addSubview:bottomView];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

//NSNumbe to NSString
-(NSString *) toString:(NSNumber *) number {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter stringFromNumber:number];
}
@end
