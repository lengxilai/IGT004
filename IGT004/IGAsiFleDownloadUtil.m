//
//  IGAsiFleDownloadUtil.m
//  IGT004
//
//  Created by 鹏 李 on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGAsiFleDownloadUtil.h"
#import "ASINetworkQueue.h"
#import "IGFileUtil.h"

#define ICON_URL @"http://www.iguor.com/IGT004/%d/%@"
#define IMAGES_URL @"http://www.iguor.com/IGT004/%d/%d.jpg"

@implementation IGAsiFleDownloadUtil

- (id)init
{
    self = [super init];
    
    if(self){
        
        if (!networkQueue) {
            networkQueue = [[ASINetworkQueue alloc] init];	
        }
        [networkQueue reset];
        [networkQueue setDelegate:self];
        [networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
        [networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
        [networkQueue setShowAccurateProgress:YES];
    }
    return self;
}

// 下载图标
-(void)addIconImage:(NSInteger)framId iconName:(NSString *)iconName{
    ASIHTTPRequest *request;
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ICON_URL,framId,iconName]]];
	[request setDownloadDestinationPath:[self getSavePath:framId]];
	[networkQueue addOperation:request];
}

// 下载组图
-(void)addImages:(NSInteger)framId count:(NSInteger)count{
    for (int i=1; i<=count; i++) {
        ASIHTTPRequest *request;
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMAGES_URL,framId,i]]];
        [request setDownloadDestinationPath:[self getSavePath:framId]];
        [networkQueue addOperation:request];
    }
}

//  开始下载
- (void)startDownload
{
    [networkQueue go];
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

- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
	NSLog(@"success");
}

- (void)imageFetchFailed:(ASIHTTPRequest *)request
{
	NSLog(@"failed");
}

@end
