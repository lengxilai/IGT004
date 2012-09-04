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
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * averageCost;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * iconName;
@property (nonatomic, retain) NSString * descriptionMemo;
@property (nonatomic, retain) NSSet *images;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
