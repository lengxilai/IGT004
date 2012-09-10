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

//根据饭店id获得图集
+(NSArray *) getPhotosByRestaurantId:(NSString *) restaurantId {
    // 创建文件管理器  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [[NSArray alloc] init];  
    NSError *error = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:[self getPathByRestaurantId:restaurantId] error:&error];
    return fileList;
}

@end
