//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationThread.h"

@protocol MultiThreadDownloaderDelegate;

@interface MultiThreadDownloader : NSObject <OperationThreadDelegate>{
    NSInteger taskid;
    NSOperationQueue *queue;
    NSString *urlString;
    NSString *savePath;
    NSInteger maxConcurrent;
    NSInteger completedOpreationCount;

    id<MultiThreadDownloaderDelegate> delegate;
    unsigned long long receivedLength;
    unsigned long long size;
}

@property(assign,nonatomic) NSInteger taskid;
@property(retain,nonatomic) id<MultiThreadDownloaderDelegate> delegate;
@property(retain,nonatomic) NSString *urlString;
@property(retain,nonatomic) NSString *savePath;
@property(assign,nonatomic) NSInteger maxConcurrent;
@property(assign,nonatomic) unsigned long long receivedLength;
@property(assign,nonatomic) unsigned long long size;

-(void)start;
-(void)echoLog:(NSString *)log;
@end


@protocol MultiThreadDownloaderDelegate <NSObject>
-(void)taskDidFinished:(MultiThreadDownloader *)loader;
-(void)taskMessageDidReceived:(NSString *)message loader:(MultiThreadDownloader*)loader;
-(void)taskProgressDidUpdated:(CGFloat)progress loader:(MultiThreadDownloader*)loader;
@end;