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
        int backWith = [self getBackGroundWidthByName:[annotation title]];
        //背景
        UIImage *backImage=[[UIImage imageNamed:@"maplabel.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:32];
        
        UIImageView *backImageView=[[UIImageView alloc] initWithImage:backImage];
        [backImageView setFrame:CGRectMake(-15, -13, backWith + 10, 25)];
        [annotationView addSubview:backImageView];
        UIImage *triangleImage = [UIImage imageNamed:@"maplabel_arrow.png"];
        UIImageView *triangleImageView=[[UIImageView alloc] initWithImage:triangleImage];
        [triangleImageView setFrame:CGRectMake(10, 10, 10, 10)];
        [annotationView addSubview:triangleImageView];
        
        //大小需要计算
        [annotationView setFrame:CGRectMake(-15, -20, backWith + 5, 25)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, -10, backWith, 18)]; 
        label.text = [annotation title];  
        //清空背景颜色  
        label.backgroundColor = [UIColor clearColor];  
        //设置字体颜色为白色  
        label.textColor = [UIColor whiteColor];  
        label.font = [UIFont fontWithName:@"Helvetica" size:A01FontSize];
        //文字居中显示  
        label.textAlignment = UITextAlignmentLeft;  
        //自动折行设置  
        label.lineBreakMode = UILineBreakModeWordWrap;  
        label.numberOfLines = 0;
        [annotationView addSubview:label];
        [self addSubview:annotationView];
        
    }
    return self;
}
-(int)getBackGroundWidthByName:(NSString *)name{
    int nameLength = [name length];
    return A01FontSize * nameLength;
}
@end
