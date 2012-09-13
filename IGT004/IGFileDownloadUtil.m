//
//  IGFileDownloadUtil.m
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGFileDownloadUtil.h"
#import "IGFileUtil.h"

#define ICON_URL @"http://www.iguor.com/IGT004/%d/%@"
#define IMAGES_URL @"http://www.iguor.com/IGT004/%d/%d.jpg"

@implementation IGFileDownloadUtil

@synthesize taskDownloader;

-(id)init{
    
    self = [super init];
    
    if(self){
        
        self.taskDownloader = [[MultiTaskDownloader alloc] init];
        taskDownloader.delegate = self;
        taskDownloader.concurrentTaskCount = 10;
    }
    return self;
    
}

// 下载图标
-(void)addIconImage:(NSInteger)framId iconName:(NSString *)iconName{
    [taskDownloader addTaskUrl:[NSString stringWithFormat:ICON_URL,framId,iconName]];
    [taskDownloader addSavePath:[self getSavePath:framId]];
}

// 下载组图
-(void)addImages:(NSInteger)framId count:(NSInteger)count{
    for (int i=1; i<=count; i++) {
        [taskDownloader addTaskUrl:[NSString stringWithFormat:IMAGES_URL,framId,i]];
        [taskDownloader addSavePath:[self getSavePath:framId]];
    }
}

//  开始下载
- (void)startDownload
{
    [taskDownloader start];
}

// 生成保存地址
-(NSString*)getSavePath:(NSInteger)framId{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path =[IGFileUtil getPathByRestaurantId:[NSString stringWithFormat:@"%d",framId]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

#pragma mark - 
-(void)taskDidReceivedMessage:(NSString *)message taskLoader:(MultiTaskDownloader *)taskLoader threadLoader:(MultiThreadDownloader *)threadLoader{
}

-(void)taskProgressDidUpdated:(CGFloat)progress taskLoader:(MultiTaskDownloader *)taskLoader threadLoader:(MultiThreadDownloader *)threadLoader{
}

-(void)taskDidFinished:(MultiTaskDownloader *)taskLoader threadLoader:(MultiThreadDownloader *)threadLoader{
    
    NSLog(@"%@",threadLoader.savePath);
}

@end
