//
//  IGCommonDefine.h
//  IGT004
//
//  Created by wu jiabin on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGCommonDefine : NSObject
typedef enum{
    TRIP_APP_ID=529403333,TOMATO_APP_ID=533655318,DAIRY_APP_ID=508014699,APPID=1234,
}CommonTag;

//A02列表页面定数
typedef enum{
    //A02中cell行高
    A02CellHight=82,
    // A02页面中tableview位置
    A02TableViewX = 0,A02TableViewY = 42,A02TableViewW = 301,A02TableViewH = 432,
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
    A02BottomLineX = 0,A02BottomLineY = 82,A02BottomLineW =320,A02BottomLineH = 1,
}A02RectDef;

//A03列表页面定数
typedef enum{
    // A03页面中上半部分view位置
    A03TopViewX = 0,A03TopViewY = 0,A03TopViewW = 320,A03TopViewH = 90,
    //标志图片显示位置
    A03IconImageViewX = 13,A03IconImageViewY = 7,A03IconImageViewW = 75,A03IconImageViewH = 70,
    //饭店名称显示位置
    A03RestaurantNameX = 100,A03RestaurantNameY = 10,A03RestaurantNameW = 200,A03RestaurantNameH = 30,
    //直线距离显示位置
    A03DistanceX = 100,A03DistanceY = 50,A03DistanceW = 90,A03DistanceH = 17,
    //人均消费显示位置
    A03AVGExpandX = 205,A03AVGExpandY = 50,A03AVGExpandW = 90,A03AVGExpandH = 17,
    //横线1位置
    A03BottomLine1X = 0,A03BottomLine1Y = 85,A03BottomLine1W =320,A03BottomLine1H = 1,
    //横线2位置
    A03BottomLine2X = 0,A03BottomLine2Y = 43,A03BottomLine2W =320,A03BottomLine2H = 1,
    //横线3位置
    A03BottomLine3X = 0,A03BottomLine3Y = 83,A03BottomLine3W =320,A03BottomLine3H = 1,
    
    // 下半部分tableview显示位置
    A03BottomTableViewX = 0,A03BottomTableViewY = 90,A03BottomTableViewW = 320,A03BottomTableViewH = 310,
    // 地址显示位置
    A03AddressX = 0,A03AddressY = 5,A03AddressW = 320,A03AddressH = 37,
    // 电话显示位置
    A03TelX = 0,A03TelY = 45,A03TelW = 320,A03TelH = 37,
    // 简介title显示位置
    A03MemoTitleX = 20,A03MemoTitleY = 100,A03MemoTitleW = 40,A03MemoTitleH = 14,
    // 简介显示位置
    A03MemoX = 20,A03MemoY = 120,A03MemoW = 270,A03MemoH = 20,
    
    // 导航栏左边按钮
    A03BarButtonLeftX=0,A03BarButtonLeftY=0,A03BarButtonLeftW=54,A03BarButtonLeftH=30,
    // 导航栏右边按钮
    A03BarButtonRightX=266,A03BarButtonRightY=0,A03BarButtonRightW=54,A03BarButtonRightH=30,
    
    //滚动图集scrollView位置
    A03ScrollViewX=0,A03ScrollViewW=320,A03ScrollViewH=100,
    
    //滚动图集image位置
    A03ScrollImageY=9,A03ScrollImageW=80,A03ScrollImageH=80,
    
}A03RectDef;

typedef enum{
    A01FontSize = 10,
    A01BackgroundViewTag = 20001,A01SearchLocationTag = 10002
}A01RectDef;
@end
