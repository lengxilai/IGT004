//
//  IGCoreDataUtil.h
//  IGT004
//
//  Created by wu jiabin on 12-9-5.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGCoreDataUtil : NSObject

//设定NSManagedObjectContext
+(void)setStaticManagedObjectContext:(NSManagedObjectContext*) managedObjectContext;

//取得NSManagedObjectContext
+(NSManagedObjectContext*)getStaticManagedObjectContext;

// 根据"表名"、"条件"、"排序规则"查询对象表，返回结果NSFetchedResultsController
+(NSFetchedResultsController*) queryForFetchedResult:(NSString *) entityName 
                                      queryCondition:(NSString *) queryCondition 
                                     sortDescriptors:(NSArray *)  sortDescriptors;
+(NSArray*) queryForArray:(NSString *) entityName 
                              queryCondition:(NSString *) queryCondition 
                             sortDescriptors:(NSArray *)  sortDescriptors;
+(NSArray*)queryForFetchedResultByExpression:(NSString *)entityName method:(NSString*) method selectColumn:(NSString*) column keyName:(NSString*) keyName queryPredicate:(NSPredicate *)predicate;
//根据表名、输入条件、排序规则、
+(NSArray*)queryForFetchedResult:(NSString *)entityName 
                  queryPredicate:(NSPredicate *)predicate 
                 sortDescriptors:(NSArray*) sortDescriptors;

// 查询对象表，返回结果arrayList
+(NSArray *)queryForArrayList:(NSString *)entityName queryPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray*) sortDescriptors;
@end
