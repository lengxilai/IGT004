//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MultiTaskDownloader.h"
#import "MultiThreadDownloader.h"

@interface MultiTaskDownloader()
-(void)startNext;
@end

@implementation MultiTaskDownloader
@synthesize taskUrlListArray;
@synthesize savePathListArray;
@synthesize concurrentTaskCount;
@synthesize delegate;

-(id)init{
    if ((self = [super init])) {
        concurrentTaskCount = 1;
        maxIndexOfStarted = 0;
        self.taskUrlListArray = [[NSMutableArray alloc] init];
        self.savePathListArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)start{
    for (int i = 0; i< self.concurrentTaskCount; i++) {
        [self startNext];
    }
}

-(void)startNext{
    if (maxIndexOfStarted < [self.taskUrlListArray count]) {
        
        NSInteger index= maxIndexOfStarted++;
        
        NSString *urlString = [self.taskUrlListArray objectAtIndex:index];
        NSString *savePath = [self.savePathListArray objectAtIndex:index];
        MultiThreadDownloader *loader = [[MultiThreadDownloader alloc] init];
        loader.taskid = maxIndexOfStarted;
        loader.delegate = self;
        loader.urlString = urlString;
        loader.savePath = savePath;
        loader.maxConcurrent = 3;
        [loader start];
    }
}

-(void)addTaskUrl:(NSString *)aUrl{
    [self.taskUrlListArray addObject:aUrl];
}

-(void)addSavePath:(NSString *)path{
    [self.savePathListArray addObject:path];
}

#pragma mark - MultiThreadDownloaderDelegate
-(void)taskDidFinished:(MultiThreadDownloader *)loader{
    if ([delegate respondsToSelector:@selector(taskDidFinished:threadLoader:)]) {
        [delegate taskDidFinished:self threadLoader:loader];
    }
    [self performSelectorOnMainThread:@selector(startNext) withObject:nil waitUntilDone:NO];
}

-(void)taskMessageDidReceived:(NSString *)message loader:(MultiThreadDownloader *)loader{
    if ([delegate respondsToSelector:@selector(taskDidReceivedMessage:taskLoader:threadLoader:)]) {
        [delegate taskDidReceivedMessage:message taskLoader:self threadLoader:loader];
    }
}

-(void)taskProgressDidUpdated:(CGFloat)progress loader:(MultiThreadDownloader *)loader{
    if ([delegate respondsToSelector:@selector(taskProgressDidUpdated:taskLoader:threadLoader:)]) {
        [delegate taskProgressDidUpdated:progress taskLoader:self threadLoader:loader];
    }
}
@end
