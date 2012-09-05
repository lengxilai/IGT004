//
//  IGCoreDataUtil.m
//  IGT004
//
//  Created by wu jiabin on 12-9-5.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGCoreDataUtil.h"

@implementation IGCoreDataUtil

//保持只有一个NSManagedObjectContext，控制线程
static NSManagedObjectContext *staticManagedObjectContext;

//设定NSManagedObjectContext
+(void)setStaticManagedObjectContext:(NSManagedObjectContext*) managedObjectContext
{
    staticManagedObjectContext = managedObjectContext;
}

//取得NSManagedObjectContext
+(NSManagedObjectContext*)getStaticManagedObjectContext
{
    return staticManagedObjectContext;
}

// 根据"表名"、"条件"、"排序规则"查询对象表，返回结果NSFetchedResultsController
+(NSFetchedResultsController*) queryForFetchedResult:(NSString *) entityName 
                                      queryCondition:(NSString *) queryCondition 
                                     sortDescriptors:(NSArray *)  sortDescriptors {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 查询对象设置
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName 
                                              inManagedObjectContext:staticManagedObjectContext];
    [request setEntity:entity];
    
    // 查询条件设置
    if(queryCondition != nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:queryCondition];
        [request setPredicate:predicate];
    }
    
    // 排序设置
    if(sortDescriptors != nil){
        [request setSortDescriptors:sortDescriptors];
    }
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:staticManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return fetchedResultsController;

}

@end
