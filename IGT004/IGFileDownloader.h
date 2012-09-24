//
//  IGFileDownloader.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGFileDownloader : MKNetworkEngine

-(MKNetworkOperation*) downloadFileFrom:(NSString*) remoteURL toFile:(NSString*) fileName;
@end

