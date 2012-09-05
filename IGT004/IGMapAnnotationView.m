//
//  IGMapAnnotationView.m
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGMapAnnotationView.h"

@implementation IGMapAnnotationView
#pragma mark -
#pragma mark 返回显示的view
-(id)initWithAnnotation:(id <MKAnnotation>)annotation{
    UIView *annotationView = [[UIView alloc] init];
    if(self = [super init]){
        UIImage *image=[[UIImage imageNamed:@"logo.jpg"] stretchableImageWithLeftCapWidth:11 topCapHeight:11];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(go2Detail:)];
        [imageView addGestureRecognizer:singleTap];
        //设置背景图片
        //        annotationView.backgroundColor =  [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"logo.jpg"]];
        [annotationView addSubview:imageView];
        //大小需要计算
        [annotationView setFrame:CGRectMake(-20, -20, 50, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 48, 18)]; 
        label.text = @"where are you? where are";  
        //清空背景颜色  
        label.backgroundColor = [UIColor clearColor];  
        //设置字体颜色为白色  
        label.textColor = [UIColor blueColor];  
        //文字居中显示  
        label.textAlignment = UITextAlignmentCenter;  
        //自动折行设置  
        label.lineBreakMode = UILineBreakModeWordWrap;  
        label.numberOfLines = 0;
        [annotationView addSubview:label];
        [self addSubview:annotationView];
        
    }
    return self;
}
@end
