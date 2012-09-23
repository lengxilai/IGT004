//
//  IGAsiFleDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@class ASINetworkQueue;

@interface IGAsiFleDownloadUtil : NSObject{
    ASINetworkQueue *networkQueue;
}

-(id)init;
// 下载图标
-(void)addIconImage:(NSInteger)framId iconName:(NSString *)iconName;
// 追加组图
-(void)addImages:(NSInteger)framId count:(NSInteger)count;
// 开始下载
-(void)startDownload;
// 完成下载
- (void)imageFetchComplete:(ASIHTTPRequest *)request;
// 下载失败
- (void)imageFetchFailed:(ASIHTTPRequest *)request;

@end
