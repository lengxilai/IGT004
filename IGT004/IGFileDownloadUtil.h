//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiTaskDownloader.h"

@interface IGFileDownloadUtil : NSObject<MultiTaskDownloaderDelegate>{
    
   MultiTaskDownloader *taskDownloader;
}

@property(retain,nonatomic) MultiTaskDownloader *taskDownloader;

-(id)init;
// 下载图标
-(void)addIconImage:(NSInteger)framId iconName:(NSString *)iconName;
// 追加组图
-(void)addImages:(NSInteger)framId count:(NSInteger)count;
// 开始下载
-(void)startDownload;

@end
