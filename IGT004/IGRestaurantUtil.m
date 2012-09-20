//
//  IGRestaurantUtil.m
//  IGT004
//
//  Created by 鹏 李 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGRestaurantUtil.h"

@implementation IGRestaurantUtil

// 更新一个饭店信息
+(void)updateRestaurant:(NSDictionary *)dir{
    
    NSString *framId = [dir objectForKey:@"id"];
    // 判断该id的数据是否已经存在
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" (id == %@ )",framId];
    NSArray* restaurantArray = [IGCoreDataUtil queryForArrayList:@"Restaurant" queryPredicate:predicate sortDescriptors:nil];
    if ([restaurantArray count] > 0) {
        Restaurant *restaurant = [restaurantArray objectAtIndex:0];
        restaurant.id =  [NSNumber  numberWithInt:[[dir objectForKey:@"id"] intValue]];
        restaurant.name = [dir objectForKey:@"name"];
        restaurant.address = [dir objectForKey:@"address"];
        restaurant.tel = [dir objectForKey:@"tel"];
        restaurant.averageCost = [NSNumber  numberWithInt:[[dir objectForKey:@"averagecost"] intValue]];
        restaurant.latitude = [dir objectForKey:@"latitude"];
        restaurant.longitude = [dir objectForKey:@"longitude"];
        restaurant.iconName = [dir objectForKey:@"iconName"];
        restaurant.descriptionMemo = [dir objectForKey:@"descriptionMemo"];
        restaurant.abbrName = [dir objectForKey:@"abbrname"];
        restaurant.ver = [NSNumber  numberWithInt:[[dir objectForKey:@"ver"] intValue]];
        
        // 删除所有旧数据
        if ([restaurant.images count] > 0) {
            [restaurant removeImages:restaurant.images];
        }
        
        // 取得组图数
        NSInteger imagecount = [[dir objectForKey:@"imagecount"] intValue];
        
        for (int i=1; i<=imagecount; i++) {
            Image *image = [[Image alloc] initWithEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]] insertIntoManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]];
            image.imageName = [NSString stringWithFormat:@"%d.jpg",i];
            // 每个图片都存一遍？
            image.descriptionMemo = restaurant.descriptionMemo;
            [restaurant addImagesObject:image];
        }
    }else {
        [IGRestaurantUtil addRestaurant:dir];
    }
    [self saveDB];
}


// 添加一个饭店信息
+(void)addRestaurant:(NSDictionary *)dir {
    
    // 创建一个饭店信息
    Restaurant *restaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]];
    restaurant.id =  [NSNumber  numberWithInt:[[dir objectForKey:@"id"] intValue]];
    restaurant.name = [dir objectForKey:@"name"];
    restaurant.address = [dir objectForKey:@"address"];
    restaurant.tel = [dir objectForKey:@"tel"];
    restaurant.averageCost = [NSNumber  numberWithInt:[[dir objectForKey:@"averagecost"] intValue]];
    restaurant.latitude = [dir objectForKey:@"latitude"];
    restaurant.longitude = [dir objectForKey:@"longitude"];
    restaurant.iconName = [dir objectForKey:@"iconName"];
    restaurant.descriptionMemo = [dir objectForKey:@"descriptionMemo"];
    restaurant.abbrName = [dir objectForKey:@"abbrname"];
    restaurant.ver = [NSNumber  numberWithInt:[[dir objectForKey:@"ver"] intValue]];
    
    // 取得组图数
    NSInteger imagecount = [[dir objectForKey:@"imagecount"] intValue];
    
    for (int i=1; i<=imagecount; i++) {
        Image *image = [[Image alloc] initWithEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]] insertIntoManagedObjectContext:[IGCoreDataUtil getStaticManagedObjectContext]];
        image.imageName = [NSString stringWithFormat:@"%d.jpg",i];
        // 每个图片都存一遍？
        image.descriptionMemo = restaurant.descriptionMemo;
        [restaurant addImagesObject:image];
    }
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
// 9.20改为得最大版本号
+(NSInteger)getMaxRestaurantId{
    NSArray *returnValue = 
    [IGCoreDataUtil queryForFetchedResultByExpression:@"Restaurant" method:@"max:" selectColumn:@"ver" keyName:@"maxOfCount" queryPredicate:nil];;
    if([returnValue count] == 0){
        return 0;
    }
    return [[[returnValue lastObject] objectForKey:@"maxOfCount"] intValue];
}
@end
