//
//  IGFileUtil.m
//  IGT004
//
//  Created by wu jiabin on 12-9-5.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGFileUtil.h"

@implementation IGFileUtil

//获取document路径
+(NSString *) getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

//根据饭店id取得相应路径
+(NSString *) getPathByRestaurantId:(NSString *) restaurantId {
    NSString *pathOfRestaurantId = [[self getDocumentPath] stringByAppendingFormat:@"%@%@", @"/images/", restaurantId];
    return pathOfRestaurantId;
}

//根据饭店id和icon名称获得标志图片
+(NSString *) getIconImageByRestaurantId:(NSString *) restaurantId forIconName:(NSString *) iconName {
    return [[self getPathByRestaurantId:restaurantId] stringByAppendingFormat:@"%@%@",@"/",iconName];
}

//根据饭店id获得图集
+(NSArray *) getPhotosByRestaurantId:(NSString *) restaurantId {
    // 创建文件管理器  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [[NSArray alloc] init];  
    NSError *error = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:[self getPathByRestaurantId:restaurantId] error:&error];
    return fileList;
}

//将初始数据文件复制到document路径
+(void)copyFileToDoc{
    
    // 复制本地数据库文件到document路径
    NSString *documentsDirectory = [IGFileUtil getDocumentPath];     
   
    // 如果文件存在则跳过
    NSString *databaseFile = [documentsDirectory stringByAppendingPathComponent:@"IGT004.sqlite"]; 
    if (![[NSFileManager defaultManager] fileExistsAtPath:databaseFile]) { 
        NSString *resourceSampleImagesFolderPath =[[NSBundle mainBundle] 
                                                   pathForResource:@"IGT004" 
                                                   ofType:@"sqlite"]; 
        NSData *mainBundleFile = [NSData dataWithContentsOfFile:resourceSampleImagesFolderPath]; 
        [[NSFileManager defaultManager] createFileAtPath:databaseFile 
                                                contents:mainBundleFile 
                                              attributes:nil]; 
    }
    
    // 复制图片文件到document路径
    NSString *imagesFolderPath = [documentsDirectory stringByAppendingPathComponent:@"images"]; 
    // 如果文件夹存在则跳过
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagesFolderPath]) {
        // 取得本地得images文件夹
        NSString *resourceImagesFolderPath =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"images"]; 
        // 取得文件夹下得子目录一览
        NSArray *arrayOfdir = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:resourceImagesFolderPath error:nil];
        // 循环目录进行文件夹和文件得复制
        for (int i = 0; i<[arrayOfdir count]; i++) {
            NSString *docPath  =  [IGFileUtil getPathByRestaurantId:[arrayOfdir objectAtIndex:i]];
            [[NSFileManager defaultManager] createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
            
            NSString *subDirPath = [resourceImagesFolderPath stringByAppendingPathComponent:[arrayOfdir objectAtIndex:i]];
            
            NSString *toDirPath = [imagesFolderPath stringByAppendingPathComponent:[arrayOfdir objectAtIndex:i]];
            
            NSArray *arrayOfImages = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:subDirPath error:nil];
            
            for (int j=0; j< [arrayOfImages count]; j++) {
                NSString *imagesF =  [subDirPath stringByAppendingPathComponent:[arrayOfImages objectAtIndex:j]];
                
                NSString *imagesT =  [toDirPath stringByAppendingPathComponent:[arrayOfImages objectAtIndex:j]];
                
                 NSData *image = [NSData dataWithContentsOfFile:imagesF];
                
                [[NSFileManager defaultManager] createFileAtPath:imagesT
                                                        contents:image 
                                                      attributes:nil]; 
            }
            
        }
        
    }
}

@end
