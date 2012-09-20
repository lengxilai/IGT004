//
//  Restaurant.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSString * abbrName;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * averageCost;
@property (nonatomic, retain) NSString * descriptionMemo;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSString * iconName;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSNumber * ver;
@property (nonatomic, retain) NSOrderedSet *images;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)insertObject:(Image *)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(Image *)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;
- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSOrderedSet *)values;
- (void)removeImages:(NSOrderedSet *)values;
@end
