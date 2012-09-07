//
//  IGUIButton.m
//  IGT004
//
//  Created by wu jiabin on 12-9-7.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGUIButton.h"

@implementation IGUIButton

//根据图片名称、按钮文字、事件方法、按钮位置等设定按钮
+ (UIButton*)getNavigationButton:(NSString *)imageName target:(id)target selector:(SEL)selector frame:(CGRect) frame {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenDisabled = YES;
    button.adjustsImageWhenHighlighted = YES;
    button.backgroundColor = [UIColor clearColor];
    return button;
    
}

@end
