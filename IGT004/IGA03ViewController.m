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
        self.title = @"舌尖上的大连";
        result = restaurant;
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
        restaurantNameLabel.font = [UIFont fontWithName:@"Arial" size:20];
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
        distanceLabel.text = [NSString stringWithFormat:@"%@%@", @"距离: ", [self getDistance:restaurant.distance]];
        [topUIView addSubview:distanceLabel];
        //人均消费
        averageCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03AVGExpandX, A03AVGExpandY, A03AVGExpandW, A03AVGExpandH)];
        averageCostLabel.backgroundColor = [UIColor clearColor];
        averageCostLabel.adjustsFontSizeToFitWidth = YES;
        averageCostLabel.textColor = [UIColor colorWithHex:0x990000 alpha:1.0];
        averageCostLabel.text = [NSString stringWithFormat:@"%@%@%@", @"人均消费: ", restaurant.averageCost, @"元"];
        [topUIView addSubview:averageCostLabel];
        //中间横线1
        line1View = [[UIView alloc] initWithFrame:CGRectMake(A03BottomLine1X, A03BottomLine1Y, A03BottomLine1W, A03BottomLine1H)];
        line1View.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [topUIView addSubview:line1View];
        
        [self.view addSubview:topUIView];
        
        
        
        //下半部分显示内容
        bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(A03BottomTableViewX, A03BottomTableViewY, A03BottomTableViewW, A03BottomTableViewH)];


        //地址
        //地址view
        addressView = [[UIView alloc] initWithFrame:CGRectMake(A03AddressX, A03AddressY, A03AddressW, A03AddressH)];
        
        addressTitelLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 40, 25)];
        addressTitelLabel.text = @"地址:";
        addressTitelLabel.textColor = [UIColor colorWithHex:0x666666 alpha:1.0];
        addressTitelLabel.backgroundColor = [UIColor clearColor];
        [addressView addSubview:addressTitelLabel];
        NSString *tempAddress = restaurant.address;
        int addressLength = [self getLengthByFont:tempAddress forFont:@"Arial" forSize:14];
        CGFloat addressHight = 0;
        NSLog(@"addressHight:%@,%d,%d",tempAddress,[tempAddress length], addressLength);
        if (addressLength<=200) {
            addressHight = 10;
        }
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, addressHight, 200, 7)];
        addressLabel.font = [UIFont fontWithName:@"Arial" size:14];
        addressLabel.text = restaurant.address;
        addressLabel.numberOfLines = 0;
        [addressLabel sizeToFit];
        addressLabel.adjustsFontSizeToFitWidth = YES;
        addressView.userInteractionEnabled=YES;
        addressLabel.backgroundColor = [UIColor clearColor];
        
        //地址右箭头图片view
        addressImgView = [[UIView alloc] initWithFrame:CGRectMake(270, 10, 10, 14)];
        addressImgView.backgroundColor = [UIColor moreImageBackgroundImageColor];
        
        UITapGestureRecognizer *touchAddress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoA05:)];
        touchAddress.numberOfTapsRequired = 1;  
        [touchAddress setEnabled :YES];  
        [touchAddress delaysTouchesBegan];  
        [touchAddress cancelsTouchesInView];
        [addressView addGestureRecognizer:touchAddress];
        [addressView addSubview:addressImgView];
        [addressView addSubview:addressLabel];

        [bottomView addSubview:addressView];
        
        //中间横线2
        line2View = [[UIView alloc] initWithFrame:CGRectMake(A03BottomLine2X, A03BottomLine2Y, A03BottomLine2W, A03BottomLine2H)];
        line2View.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [bottomView addSubview:line2View];
        
        //电话
        telView = [[UIView alloc] initWithFrame:CGRectMake(A03TelX, A03TelY, A03TelW, A03TelH)];
        telView.userInteractionEnabled = YES;
//        telView.backgroundColor = [UIColor grayColor];
        telTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 40, 14)];
        telTitleLabel.textColor = [UIColor colorWithHex:0x666666 alpha:1.0];
        telTitleLabel.backgroundColor = [UIColor clearColor];
        telTitleLabel.text = @"电话:";
        [telView addSubview:telTitleLabel];
        telLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 13, 240, 14)];
        telLabel.text = restaurant.tel;
        telLabel.font = [UIFont fontWithName:@"Arial" size:14];
        telLabel.adjustsFontSizeToFitWidth = YES;
        telLabel.backgroundColor = [UIColor clearColor];
        
        telImageView = [[UIView alloc] initWithFrame:CGRectMake(270, 13, 10, 14)];
        telImageView.backgroundColor = [UIColor moreImageBackgroundImageColor];
        
        
        UITapGestureRecognizer *touchTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callTel:)];
        touchTel.numberOfTapsRequired = 1;  
        [touchTel setEnabled :YES];  
        [touchTel delaysTouchesBegan];  
        [touchTel cancelsTouchesInView];
        [telView addGestureRecognizer:touchTel];
        
        [telView addSubview:telLabel];
        [telView addSubview:telImageView];
        [bottomView addSubview:telView];
        
        //中间横线3
        line3View = [[UIView alloc] initWithFrame:CGRectMake(A03BottomLine3X, A03BottomLine3Y, A03BottomLine3W, A03BottomLine3H)];
        line3View.backgroundColor = [UIColor bottomLineBackgroundImageColor];
        [bottomView addSubview:line3View];
        
        //简介
        memoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(A03MemoTitleX, A03MemoTitleY, A03MemoTitleW, A03MemoTitleH)];
        memoTitleLabel.text = @"介绍:";
        memoTitleLabel.backgroundColor = [UIColor clearColor];
        memoTitleLabel.textColor = [UIColor colorWithHex:0x666666 alpha:1.0];
        [bottomView addSubview:memoTitleLabel];
        
        NSString *tempMemo = [NSString stringWithFormat:@"%@%@", @"      ", restaurant.descriptionMemo];
        int memoLength = [self getLengthByFont:tempMemo forFont:@"Arial" forSize:14];
        int memoHight = memoLength / A03MemoY + 1;
        if (memoHight == 1) {
            memoHight = memoHight + 1;
        }
        
        memoTextView = [[UITextView alloc] initWithFrame:CGRectMake(A03MemoX, A03MemoY, A03MemoW, A03MemoH*memoHight)];
        memoTextView.text = [NSString stringWithFormat:@"%@%@", @"      ", restaurant.descriptionMemo];
        [memoTextView setEditable:NO];

        memoTextView.font = [UIFont fontWithName:@"Arial" size:14];
        memoTextView.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:memoTextView];

        //导航设定
        UIButton *leftButton = [IGUIButton getNavigationButton:@"nav_l_btn.png" title:(NSString*)@"返回" target:self selector:@selector(goBack) frame:CGRectMake(A03BarButtonLeftX, A03BarButtonLeftY, A03BarButtonLeftW, A03BarButtonLeftH)];
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        //取出饭店id下的所有图片
        NSArray *fileList = [IGFileUtil getPhotosByRestaurantId:[self toString:restaurant.id]];
        if (fileList != nil && fileList.count != 0) {
            //图集scrollView
            photoView = [self setPhotoView:restaurant];
            [bottomView addSubview:photoView];
        }
        
        bottomView.contentSize = CGSizeMake(320, [self getUILabelHeight:memoTextView]+340);
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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(A03ScrollViewX, [self getUILabelHeight:memoTextView]+160, A03ScrollViewW, A03ScrollViewH)];
    scrollView.backgroundColor = [UIColor colorWithHex:0xd0d0d0 alpha:1.0];
    
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
    IGPhotoImage *touchedImage = (IGPhotoImage*)gestureRecognizer.view;
    touchedImage.parentview = self.view;
    [touchedImage handleDoubleTap:nil];
    
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
//打电话
-(void) callTel:(UITapGestureRecognizer *)recognizer {
    NSString *tel = [NSString stringWithFormat:@"%@%@", @"tel://", result.tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    
}

//NSNumbe to NSString
-(NSString *) toString:(NSNumber *) number {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter stringFromNumber:number];
}

-(void) gotoA05:(UITapGestureRecognizer *)recognizer {
    IGA05ViewController *a01ViewController = [[IGA05ViewController alloc] initWithRestautant:result];
    [self.navigationController pushViewController:a01ViewController animated:YES];
}

//根据字体和字体大小取得其长度
-(int)getLengthByFont:(NSString *)inputStr forFont:(NSString*) font forSize:(int) fontSize{
    int nameLength = [inputStr length];
    CGSize size = [inputStr sizeWithFont:[UIFont fontWithName:font size:fontSize] constrainedToSize:CGSizeMake(14*nameLength, MAXFLOAT)];
    return size.width;
}

@end
