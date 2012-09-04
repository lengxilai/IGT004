//
//  UIColor+Hex.h
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (IGColor)
//根据Hex颜色创建UIColor
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
//横线背景图片
+ (UIColor*)bottomLineBackgroundImageColor;
@end