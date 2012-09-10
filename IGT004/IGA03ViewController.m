//
//  IGA03ViewController.m
//  IGT004
//
//  Created by wu jiabin on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGA03ViewController.h"


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
        bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(A03BottomTableViewX, A03BottomTableViewY, A03BottomTableViewW, A03BottomTableViewH)];


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

        //导航设定
        UIButton *leftButton = [IGUIButton getNavigationButton:@"nav_l_btn.png" title:(NSString*)@"返回" target:self selector:@selector(goBack) frame:CGRectMake(A03BarButtonLeftX, A03BarButtonLeftY, A03BarButtonLeftW, A03BarButtonLeftH)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        //图集scrollView
        photoView = [self setPhotoView:restaurant];
        
        [bottomView addSubview:photoView];
        bottomView.contentSize = CGSizeMake(320, [self getUILabelHeight:memoLabel]+320);
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

// 点击返回按钮
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取UILabel的高度
-(double) getUILabelHeight:(UILabel *) label {
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}

//设定滚动图集的图片和位置
-(UIScrollView*) setPhotoView:(Restaurant*) restaurant {
    // 滚动图集的Y轴大小＝简介高度＋电话＋地址＋常量
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(A03ScrollViewX, [self getUILabelHeight:memoLabel]+120, A03ScrollViewW, A03ScrollViewH)];
    scrollView.backgroundColor = [UIColor grayColor];
    
    //取出饭店id下的所有图片
    NSArray *fileList = [IGFileUtil getPhotosByRestaurantId:[self toString:restaurant.id]];
    //要从数组中删除标志图片，所以需要用NSMutableArray
    NSMutableArray *photosArray = [NSMutableArray arrayWithArray:fileList];
    //除去标志图片
    [photosArray removeObject:restaurant.iconName];
    //算出ScrollView的宽度（减去标志图片）
    NSInteger maxWidth = (photosArray.count)*90;
    scrollView.contentSize = CGSizeMake(maxWidth, A03ScrollViewH);
    
    //循环向ScrollView中添加图片
    for (int i=0;i<photosArray.count;i++) {
        NSString *photoName = [photosArray objectAtIndex:i];
        UIImage *photoImg = [[UIImage alloc] initWithContentsOfFile: [IGFileUtil getIconImageByRestaurantId:[self toString:restaurant.id] forIconName:photoName]];
        CGSize photoSize =[photoImg size];
        NSLog(@"宽%f", photoSize.width);
        NSLog(@"高%f", photoSize.height);
        //每个图片的位置
        UIImageView *photoImgView = [[IGPhotoImage alloc] initWithFrame:CGRectMake(i*90+5, A03ScrollImageY, A03ScrollImageW, A03ScrollImageH)];
        [photoImgView setImage:photoImg];

        [photoImgView setTag: (7000 + i)];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClicked:)];
        [photoImgView addGestureRecognizer:singleTap];
        //什么意思？
        [photoImgView setUserInteractionEnabled:YES];
        [photoImgView setMultipleTouchEnabled:YES];
        
        [scrollView addSubview:photoImgView];
    }
    [scrollView setDelegate:self];
    return scrollView;
}

// 点击照片后，显示大照片
-(void)photoClicked:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%@", @"na ni na ni na ni");
    
    

    IGPhotoImage *touchedImage = (IGPhotoImage*)gestureRecognizer.view;
    [touchedImage setDoubleTap:self.view];
    
//    [[IGPhotoImage alloc] setDoubleTap:touchedImage];
//
//    UIScrollView *touchedImageController = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 30, 200, 200)];
//    [touchedImage setFrame:CGRectMake(0, 0, 200, 200)];
//    touchedImageController.backgroundColor = [UIColor redColor];
//    [touchedImageController addSubview:touchedImage];
//    [self.view addSubview:touchedImageController];
//    [touchedImageController showPhoto:touchedImage.image];
//    UIImageView *touchedImage = [[UIImageView alloc] init];
//    touchedImage = (UIImageView *)gestureRecognizer.view;
//    CGRect newRect = CGRectInset([touchedImage frame], 0, 0);    
//
//    [touchedImage setFrame:newRect];
//    
//    [self.view addSubview:touchedImage];
    NSLog(@"%@", @"ok");
}


//NSNumbe to NSString
-(NSString *) toString:(NSNumber *) number {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter stringFromNumber:number];
}
@end
