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
    A02CellHight=79,
    // A02页面中tableview位置
    A02TableViewX = 9,A02TableViewY = 10,A02TableViewW = 301,A02TableViewH = 390,
    //饭店名称显示位置
    A02RestaurantNameX = 20,A02RestaurantNameY = 5,A02RestaurantNameW = 200,A02RestaurantNameH = 10,
    //饭店地址显示位置
    A02RestaurantAddressX = 20,A02RestaurantAddressY = 20,A02RestaurantAddressW = 200,A02RestaurantAddressH = 10,
    //直线距离显示位置
    A02DistanceX = 20,A02DistanceY = 30,A02DistanceW = 20,A02DistanceH = 10,
    //人均消费显示位置
    A02AVGExpandX = 50,A02AVGExpandY = 30,A02AVGExpandW = 20,A02AVGExpandH = 10,
}A02RectDef;
@end
