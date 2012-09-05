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
        //设置背景图片
        annotationView.backgroundColor =  [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"annotationBackground.png"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 150)]; 
        label.text = @"where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you?";  
        //清空背景颜色  
        label.backgroundColor = [UIColor clearColor];  
        //设置字体颜色为白色  
        label.textColor = [UIColor whiteColor];  
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
