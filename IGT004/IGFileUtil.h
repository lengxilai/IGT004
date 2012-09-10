//
//  IGFileUtil.h
//  IGT004
//
//  Created by wu jiabin on 12-9-5.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGFileUtil : NSObject

//获取document路径
+(NSString *) getDocumentPath;
//根据饭店id取得相应路径
+(NSString *) getPathByRestaurantId:(NSString *) restaurantId;
//根据饭店id和icon名称获得标志图片
+(NSString *) getIconImageByRestaurantId:(NSString *) restaurantId forIconName:(NSString *) iconName;
//根据饭店id获得图集
+(NSArray *) getPhotosByRestaurantId:(NSString *) restaurantId;

@end
