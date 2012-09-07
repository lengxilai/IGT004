//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UUL unsigned long long

@protocol OperationThreadDelegate ;

@interface OperationThread : NSOperation {
    NSInteger opid;
    NSString *urlString;
    NSURLConnection *connection;
    NSMutableURLRequest *request;
    NSString *path;
    unsigned long long startOffset;
    unsigned long long length;
    UUL receivedLength;
    UUL currentOffset;
    BOOL done;
    NSFileHandle *fh;
    NSMutableData *dataRecv;
    NSCondition *condition;
    id<OperationThreadDelegate> delegate;
}
@property(retain) id<OperationThreadDelegate> delegate;
@property(retain) NSFileHandle *fh;
@property(retain) NSString *urlString;
@property(assign) NSInteger opid;
@property(retain) NSString *path;
@property(assign) unsigned long long startOffset;
@property(assign) unsigned long long length;

-(void)echoLog:(NSString *)log;
@end

@protocol OperationThreadDelegate <NSObject>
-(void)threadMessageDidReceived:(NSString *)message;
-(void)lengthOfReceivedData:(unsigned long long)length;
@end