//
//  Restaurant.h
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
//饭店名称
@property (nonatomic, retain) NSString * name;
//电话
@property (nonatomic, retain) NSString * tel;
//地址
@property (nonatomic, retain) NSString * address;
//人均消费
@property (nonatomic, retain) NSNumber * averageCost;
//坐标
@property (nonatomic, retain) NSString * latitude;
//坐标
@property (nonatomic, retain) NSString * longitude;
//标志图标
@property (nonatomic, retain) NSString * iconName;
//介绍内容
@property (nonatomic, retain) NSString * descriptionMemo;
//图片集合
@property (nonatomic, retain) NSSet *images;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
