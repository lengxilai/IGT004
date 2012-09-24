//
//  IGFileDownloader.m
//  IGT004
//
//  Created by 鹏 李 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGFileDownloader.h"

@implementation IGFileDownloader


-(MKNetworkOperation*) downloadFileFrom:(NSString*) remoteURL toFile:(NSString*) filePath {

MKNetworkOperation *op = [self operationWithURLString:remoteURL 
                                               params:nil
                                           httpMethod:@"GET"];

[op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                        append:YES]];

[self enqueueOperation:op];
return op;
}
@end
