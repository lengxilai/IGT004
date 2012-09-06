//
//  IGCommonDefine.h
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGCommonDefine : NSObject

//A02列表页面定数
typedef enum{
    //A02中cell行高
    A02CellHight=82,
    // A02页面中tableview位置
    A02TableViewX = 0,A02TableViewY = 0,A02TableViewW = 301,A02TableViewH = 390,
    //标志图片显示位置
    A02IconImageViewX = 13,A02IconImageViewY = 7,A02IconImageViewW = 75,A02IconImageViewH = 70,
    //饭店名称显示位置
    A02RestaurantNameX = 100,A02RestaurantNameY = 10,A02RestaurantNameW = 180,A02RestaurantNameH = 20,
    //饭店地址显示位置
    A02RestaurantAddressX = 100,A02RestaurantAddressY = 35,A02RestaurantAddressW = 200,A02RestaurantAddressH = 17,
    //直线距离显示位置
    A02DistanceX = 100,A02DistanceY = 60,A02DistanceW = 80,A02DistanceH = 15,
    //人均消费显示位置
    A02AVGExpandX = 200,A02AVGExpandY = 60,A02AVGExpandW = 80,A02AVGExpandH = 15,
    //列表页底部横线位置
    A02BottomLineX = 45,A02BottomLineY = 82,A02BottomLineW =230,A02BottomLineH = 1,
}A02RectDef;
typedef enum{
    A01FontSize = 10,
}A01RectDef;
@end
