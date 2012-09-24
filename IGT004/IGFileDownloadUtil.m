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

@synthesize downloader,urlListArray,savePathListArray;


-(id)init{
    
    self = [super init];
    
    if(self){
        fileDownLoader = [[IGFileDownloader alloc] initWithHostName:nil customHeaderFields:nil];
        self.urlListArray = [[NSMutableArray alloc] init];
        self.savePathListArray = [[NSMutableArray alloc] init];
    }
    return self;
    
}

// 下载图标
-(void)addIconImage:(NSInteger)framId iconName:(NSString *)iconName{
    [self.urlListArray addObject:[NSString stringWithFormat:ICON_URL,framId,iconName]];
    [self.savePathListArray addObject:[self getSavePath:framId]];
}

// 下载组图
-(void)addImages:(NSInteger)framId count:(NSInteger)count{
    for (int i=1; i<=count; i++) {
        [self.urlListArray addObject:[NSString stringWithFormat:IMAGES_URL,framId,i]];
        [self.savePathListArray addObject:[self getSavePath:framId]];
    }
}

//  开始下载
-(void)startDownload:(NSInteger)index
{
    if([self.urlListArray count]==index){
        return;
    }
    self.downloader = [fileDownLoader downloadFileFrom:[urlListArray objectAtIndex:index] 
                                                toFile:[savePathListArray objectAtIndex:index]]; 
    
    [self.downloader onDownloadProgressChanged:^(double progress) {
    }];
    [self.downloader onCompletion:^(MKNetworkOperation* completedRequest) {
        NSLog(@"download sussess"); 
        [self startDownload:index+1];
    }onError:^(NSError* error) {
         NSLog(@"download  error");                             
    }];
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
@end
