//
//  IGJsonUtil.m
//  IGT004
//
//  Created by 鹏 李 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IGJsonUtil.h"

#define DATA_URL @"http://www.iguor.com/IGT004/data.php?fromid=%d"

@implementation IGJsonUtil

@synthesize state;

- (id)init{
    self = [super init];
    if(self){
        // 处理开始
        state = json_start;
        adapter = [[SBJsonStreamParserAdapter alloc] init];
        adapter.delegate = self;
        parser = [[SBJsonStreamParser alloc] init];
        parser.delegate = adapter;
        parser.supportMultipleDocuments = YES;
    }
    return self;
}

-(void)getNewData{
    // 取得当前数据库的最大ID进行通信
    NSURLRequest *theRequest=[NSURLRequest 
                              requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:DATA_URL,[IGRestaurantUtil getMaxRestaurantId]]]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                              timeoutInterval:60.0];
    NSLog(@"%@",[NSString stringWithFormat:DATA_URL,[IGRestaurantUtil getMaxRestaurantId]]);
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

#pragma mark SBJsonStreamParserAdapterDelegate methods
- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
    
    // 处理中
    state = json_ing;
    
    for (int i = 0; i < [array count]; i++) {
        // 图片取得
        NSInteger framId = [[[array objectAtIndex:i] objectForKey:@"id"] intValue];
        NSString *iconName = [[array objectAtIndex:i] objectForKey:@"iconName"];
        NSInteger imagecount = [[[array objectAtIndex:i] objectForKey:@"imagecount"] intValue];
        
        IGFileDownloadUtil *util = [[IGFileDownloadUtil alloc] init];
        [util addIconImage:framId iconName:iconName];
        [util addImages:framId count:imagecount];
        [util startDownload];
         
        
        // 数据库登陆
        //[IGRestaurantUtil addRestaurant:[array objectAtIndex:i]];
    }
}

#pragma mark NSURLConnectionDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	SBJsonStreamParserStatus status = [parser parse:data];
	
	if (status == SBJsonStreamParserError) {
		// 发生转换错误
        state = json_error;
	} 
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // 发生连接错误
    state = json_error;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // 全部处理完成后
    state = json_over;
}
@end
