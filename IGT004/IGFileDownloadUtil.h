//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGFileDownloader.h"
#import "Downloader.h"
#import "IGRestaurantUtil.h"

@interface IGFileDownloadUtil : NSObject{
    
    MKNetworkOperation *downloader;
    //NSMutableArray *urlListArray;
    //NSMutableArray *savePathListArray;
    IGFileDownloader *fileDownLoader;
    NSArray * dArrayList;
}

@property(retain,nonatomic) NSArray *dArrayList;

//@property(retain,nonatomic) NSMutableArray *urlListArray;
//@property(retain,nonatomic) NSMutableArray *savePathListArray;
@property(retain,nonatomic) MKNetworkOperation *downloader;

-(id)init;
// 下载图标
-(void)addIconImage:(NSInteger)framId iconName:(NSString *)iconName;
// 追加组图
-(void)addImages:(NSInteger)framId count:(NSInteger)count;
// 开始下载
-(void)startDownload:(NSInteger)index;

@end
