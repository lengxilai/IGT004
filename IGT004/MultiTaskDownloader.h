//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiThreadDownloader.h"

@protocol MultiTaskDownloaderDelegate;

@interface MultiTaskDownloader : NSObject <MultiThreadDownloaderDelegate>{
    NSMutableArray *taskUrlListArray;
    NSMutableArray *savePathListArray;
    NSInteger concurrentTaskCount;
    NSInteger   maxIndexOfStarted;
    id<MultiTaskDownloaderDelegate> delegate;
}

@property(retain,nonatomic) id<MultiTaskDownloaderDelegate> delegate;
@property(assign,nonatomic) NSInteger concurrentTaskCount;
@property(retain,nonatomic) NSMutableArray *taskUrlListArray;
@property(retain,nonatomic) NSMutableArray *savePathListArray;

-(void)start;
-(void)addTaskUrl:(NSString *)aUrl;
-(void)addSavePath:(NSString *)path;
@end


@protocol MultiTaskDownloaderDelegate <NSObject>
@optional
-(void)taskDidFinished:(MultiTaskDownloader *)taskLoader threadLoader:(MultiThreadDownloader *)threadLoader;
-(void)taskDidReceivedMessage:(NSString *)message taskLoader:(MultiTaskDownloader *)taskLoader threadLoader:(MultiThreadDownloader *)threadLoader;
-(void)taskProgressDidUpdated:(CGFloat)progress taskLoader:(MultiTaskDownloader *)taskLoader threadLoader:(MultiThreadDownloader *)threadLoader;

@end