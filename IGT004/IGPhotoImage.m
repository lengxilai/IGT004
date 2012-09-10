//
//  IGPhotoImage.m
//  IGT004
//
//  Created by wu jiabin on 12-9-10.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGPhotoImage.h"
#import <QuartzCore/QuartzCore.h>

@implementation IGPhotoImage

@synthesize parentview;  
@synthesize imageBackground,imageBackView,maskView;  

@interface IGPhotoImage (private)  
- (void)fadeIn;  
- (void)fadeOut;  
- (void)closeImage:(id)sender;  
@end



/* 
 * setDoubleTap 初始化图片 
 * @parent UIView 父窗口 
 */  
- (void)setDoubleTap:(UIView*) parent  
{  
    parentview=parent;  
    parentview.userInteractionEnabled=YES;  
    self.userInteractionEnabled=YES;  

    UITapGestureRecognizer *doubleTapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];  
    doubleTapRecognize.numberOfTapsRequired = 2;  
    [doubleTapRecognize setEnabled :YES];  
    [doubleTapRecognize delaysTouchesBegan];  
    [doubleTapRecognize cancelsTouchesInView];  

    [self addGestureRecognizer:doubleTapRecognize];  

}


#pragma UIGestureRecognizer Handles  
/* 
 * handleDoubleTap 双击图片弹出单独浏览图片层 
 * recognizer 双击手势 
 */  
-(void) handleDoubleTap:(UITapGestureRecognizer *)recognizer  
{     
if (imageBackView==nil) {  
    if( [[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeRight)  
    {  
        
        frameRect = CGRectMake(0, 0, parentview.frame.size.height+20, parentview.frame.size.width);  
    }else  
    {     
        frameRect = CGRectMake(0, 0, parentview.frame.size.width, parentview.frame.size.height+20);  
    }  
    imageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self getDisplaySize:self.image].width+20, [self getDisplaySize:self.image].height+60)];  
    imageBackView.backgroundColor = [UIColor grayColor];  

    imageBackView.layer.cornerRadius = 5.0; //根据需要调整  
    
    [[imageBackView layer] setShadowOffset:CGSizeMake(10, 10)];  
    [[imageBackView layer] setShadowRadius:5];  
    [[imageBackView layer] setShadowOpacity:0.7];  
    [[imageBackView layer] setShadowColor:[UIColor blackColor].CGColor];  
    
    maskView = [[UIView alloc]initWithFrame:frameRect];  
    maskView.backgroundColor = [UIColor grayColor];  
    maskView.alpha=0.7;  
    
    UIImage *imagepic = self.image;  
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, [self getDisplaySize:self.image].width, [self getDisplaySize:self.image].height)];  
    [view setImage:imagepic];  
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];  
    
    UIImage *closeimg = [UIImage imageNamed:@"closeImage.png"];  
    btn.frame = CGRectMake([self getDisplaySize:self.image].width-20,0, closeimg.size.width,closeimg.size.height);  
    [btn setBackgroundImage:closeimg forState:UIControlStateNormal];  
    [btn addTarget:self action:@selector(closeImage:) forControlEvents:UIControlEventTouchUpInside];  
    
    [imageBackView addSubview:view];  
    [parentview addSubview:maskView];  
    imageBackView.center= CGPointMake((frameRect.origin.x+frameRect.size.width)/2  
                                      ,(frameRect.origin.y+frameRect.size.height)/2);  
    [parentview addSubview:imageBackView];  
    [imageBackView addSubview:btn];  
    [parentview bringSubviewToFront:imageBackView];  
    
    [self fadeIn];  
    
    
}  
}  

/* 
 * fadeIn 图片渐入动画 
 */  
-(void)fadeIn  
{  
imageBackView.transform = CGAffineTransformMakeScale(1.3, 1.3);  
imageBackView.alpha = 0;  
[UIView animateWithDuration:.55 animations:^{  
    imageBackView.alpha = 1;  
    imageBackView.transform = CGAffineTransformMakeScale(1, 1);  
}];  

}  

/* 
 * fadeOut 图片逐渐消失动画 
 */  
- (void)fadeOut  
{  
[UIView animateWithDuration:.35 animations:^{  
    imageBackView.transform = CGAffineTransformMakeScale(1.3, 1.3);  
    imageBackView.alpha = 0.0;  
} completion:^(BOOL finished) {  
    if (finished) {  
        [imageBackView removeFromSuperview];  
    }  
}];  
}  

/* 
 * closeImage 关闭弹出图片层 
 */  
-(void)closeImage:(id)sender  
{  
[self fadeOut];  
imageBackView=nil;  
[maskView removeFromSuperview];  
maskView=nil;  
}

-(CGSize) getDisplaySize:(UIImage *) image {
// 计算照片的宽度和高度，最大宽度320,最大高度450
CGSize size = image.size;
CGFloat ratio = 0;
if (size.width > size.height) {
    ratio = 320 / size.width; 
    if (ratio * size.height > 450) {
        ratio = ratio * 450 / (size.height * ratio);
    } 
}
else {
    ratio = 450 / size.height;
    if (ratio * size.width > 320) {
        ratio = ratio * 320 / (size.width * ratio);
    }
}
CGSize displaySize = CGSizeMake(ratio * size.width, ratio * size.height);
return displaySize;
}

@end
