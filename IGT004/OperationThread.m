//
//  IGFileDownloadUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OperationThread.h"


@implementation OperationThread
@synthesize path;
@synthesize startOffset;
@synthesize length;
@synthesize opid;
@synthesize  urlString;
@synthesize fh;
@synthesize delegate;

-(void)main{
//        NSLog(@"%d %llu %llu",opid,startOffset,length);
        [self echoLog:[NSString stringWithFormat:@"Thread %d created.",opid]];
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:0 timeoutInterval:60];
        NSString *rangeValue = [NSString stringWithFormat:@"bytes=%llu-%llu",startOffset,startOffset + length - 1];
        [request setValue:rangeValue forHTTPHeaderField:@"Range"];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
        receivedLength = 0;
        done = NO;
    
        if (connection != nil) {
            do{
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];    //这个NSRunLoop貌似很有用!!!
            } while (!done) ;
        }

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self echoLog:[NSString stringWithFormat:@"Thread %d start to download.",opid]];
    dataRecv = [[NSMutableData alloc] init];
    condition =[[NSCondition alloc] init];
    self.fh = [NSFileHandle fileHandleForWritingAtPath:path];
    [fh seekToFileOffset:startOffset];
    currentOffset = startOffset;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    unsigned long long len = [data length];
    if ([delegate respondsToSelector:@selector(lengthOfReceivedData:)]) {
        [delegate lengthOfReceivedData:len];
    }
    receivedLength += len;
    [self.fh writeData:data];
    currentOffset += len;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)_connection{
    
    [condition lock];
    [self.fh closeFile];
    [condition unlock];
    done = YES;
    connection = nil;
    request = nil;
//    NSLog(@"thread %d finished",opid);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"err%@",[error description]);
    [self  echoLog:@"cannot connect to the resource "];
}


-(void)echoLog:(NSString *)log{
    if ([delegate respondsToSelector:@selector(threadMessageDidReceived:)]) {
        [delegate threadMessageDidReceived:log];
    }
}
@end
