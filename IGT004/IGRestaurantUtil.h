//
//  IGRestaurantUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "IGCoreDataUtil.h"
#import "Restaurant.h"
#import "Image.h"

@interface IGRestaurantUtil : NSObject

// 添加饭店信息
+(void)addRestaurant:(NSDictionary *)array;

// 更新饭店信息
+(void)updateRestaurant:(NSDictionary *)array;

// 保存数据
+(void)saveDB;

// 取得Restaurant中最大ID
+(NSInteger)getMaxRestaurantId;

@end
