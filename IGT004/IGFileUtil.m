//
//  IGFileUtil.m
//  IGT004
//
//  Created by wu jiabin on 12-9-5.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGFileUtil.h"

@implementation IGFileUtil

//获取document路径
+(NSString *) getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

//根据饭店id取得相应路径
+(NSString *) getPathByRestaurantId:(NSString *) restaurantId {
    NSString *pathOfRestaurantId = [[self getDocumentPath] stringByAppendingFormat:@"%@%@", @"/images/", restaurantId];
    return pathOfRestaurantId;
}

//根据饭店id和icon名称获得标志图片
+(NSString *) getIconImageByRestaurantId:(NSString *) restaurantId forIconName:(NSString *) iconName {
    return [[self getPathByRestaurantId:restaurantId] stringByAppendingFormat:@"%@%@",@"/",iconName];
}

@end
