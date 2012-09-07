//
//  IGUIButton.h
//  IGT004
//
//  Created by wu jiabin on 12-9-7.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGUIButton : NSObject

//根据图片名称、按钮文字、事件方法、按钮位置等设定按钮
+ (UIButton*)getNavigationButton:(NSString *)imageName target:(id)target selector:(SEL)selector frame:(CGRect) frame;

@end
