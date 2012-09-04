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

@property (nonatomic, retain) NSNumber * restaurantId;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) Restaurant *imageRelationship;

@end
