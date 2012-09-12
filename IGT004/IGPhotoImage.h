//
//  IGPhotoImage.h
//  IGT004
//
//  Created by wu jiabin on 12-9-10.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGPhotoImage : UIImageView {
    //父窗口，即用将UIImageEx所加到的UIView  
    UIView *parentview;
    //放大图片后的背景
    UIImageView *imageBackground;
    //单独查看时的背景
    UIView* imageBackView;
    //遮罩层
    UIView* maskView;
    CGRect frameRect; 
}

@property (nonatomic,retain) UIView *parentview;  
@property (nonatomic,retain) UIImageView *imageBackground;  
@property (nonatomic,retain) UIView* imageBackView;  
@property (nonatomic,retain) UIView* maskView;

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer;  

//必须设置的  
- (void)setDoubleTap:(UIView*)imageView; 

@end
