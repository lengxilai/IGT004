//
//  UIColor+Hex.m
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "UIColor+IGColor.h"

@implementation UIColor (IGColor)
//根据Hex颜色创建UIColor
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0 
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

//横线背景图片
+ (UIColor*)bottomLineBackgroundImageColor {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_line.png"]];
}
@end
