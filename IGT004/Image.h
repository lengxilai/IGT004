//
//  Image.h
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface Image : NSManagedObject
//饭店id
@property (nonatomic, retain) NSNumber * restaurantId;
//图片名称
@property (nonatomic, retain) NSString * imageName;
//图片介绍
@property (nonatomic, retain) NSString * descriptionMemo;
@property (nonatomic, retain) Restaurant *imageRelationship;

@end
