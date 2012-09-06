//
//  IGRestaurantUtil.m
//  IGT004
//
//  Created by 鹏 李 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGRestaurantUtil.h"

@implementation IGRestaurantUtil


// 添加一个饭店信息
+(void)addRestaurant:(NSDictionary *)dir {
    // 创建一个饭店信息
    Restaurant *restaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]];
    restaurant.id =  [NSNumber  numberWithInt:[[dir objectForKey:@"id"] intValue]];
    restaurant.name = [dir objectForKey:@"name"];
    restaurant.address = [dir objectForKey:@"address"];
    restaurant.tel = [dir objectForKey:@"tel"];
    restaurant.averageCost = [NSNumber  numberWithInt:[[dir objectForKey:@"averageCost"] intValue]];
    restaurant.latitude = [dir objectForKey:@"latitude"];
    restaurant.longitude = [dir objectForKey:@"longitude"];
    restaurant.iconName = [dir objectForKey:@"iconName"];
    restaurant.descriptionMemo = [dir objectForKey:@"descriptionMemo"];
    restaurant.abbrName = [dir objectForKey:@"abbrname"];
    
    // 取得组图数
    NSInteger imagecount = [[dir objectForKey:@"imagecount"] intValue];
    
    for (int i=1; i<=imagecount; i++) {
        Image *image = [[Image alloc] initWithEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]] insertIntoManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]];
        image.imageName = [NSString stringWithFormat:@"%d.jpg",i];
        // 每个图片都存一遍？
        image.descriptionMemo = restaurant.descriptionMemo;
        [restaurant addImagesObject:image];
    }
    
    [self saveDB];
  }

// 保存数据库
+(void)saveDB{
    NSError *error = nil;
    if (![[IGCoreDataUtil getStaticManagedObjectContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

// 取得最大的RestaurantId
+(NSInteger)getMaxRestaurantId{
    NSArray *returnValue = 
    [IGCoreDataUtil queryForFetchedResultByExpression:@"Restaurant" method:@"max:" selectColumn:@"id" keyName:@"maxOfCount" queryPredicate:nil];;
    if([returnValue count] == 0){
        return 0;
    }
    return [[[returnValue lastObject] objectForKey:@"maxOfCount"] intValue] + 1;
}
@end
